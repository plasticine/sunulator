defmodule Sunulator.Locations.Location.IlluminationLoader do
  @moduledoc """
  Parse Location and Location Irradiance data from CSV. These CSV data files have a bit of a weird
  structure, though it’s apparently idiomatic, so we’ll deal with it;

  ```
  + location header
  | location row 1
  | ...
  | location row n
  + data header
  | location row 1 data row 1
  | ...
  | location row 1 data row 17_520
  | location row 2 data row 1
  | ...
  | location row 2 data row 17_520
  ```
  """

  defmodule CSVParser do
    NimbleCSV.define(Parser, separator: ",", escape: "\"")

    def parse(file) do
      file
      |> stream_rows
      |> parse_rows
    end

    defp stream_rows(file) do
      file
      |> File.stream!(read_ahead: 100_000)
      |> Parser.parse_stream(skip_headers: true)
    end

    defp parse_rows(stream) do
      stream
      |> Stream.chunk_while(
        [],
        fn row, acc ->
          case parse_row_type(row) do
            [:header] -> {:cont, acc, []}
            [:data, _] -> {:cont, [row | acc]}
          end
        end,
        fn
          [] -> {:cont, []}
          acc -> {:cont, Enum.reverse(acc), []}
        end
      )
      |> StreamSplit.pop()
      |> case do
        {locations, illumination_samples} ->
          locations =
            locations
            |> Stream.map(&parse_location_row/1)

          illumination_samples =
            illumination_samples
            |> Stream.flat_map(fn x -> x end)
            |> Stream.map(&parse_illumination_sample_row/1)
            |> Stream.chunk_every(intervals_per_year())

          Stream.zip(locations, illumination_samples)
      end
    end

    defp parse_row_type(row) do
      case row do
        # Location header lines
        ["Location", "City", "Region" | _] -> [:header]
        # Location data header row
        ["Year", "Month", "Day" | _] -> [:header]
        # Any other row is data!
        _ -> [:data, row]
      end
    end

    defp parse_location_row([_, name, _, _, latitude, longitude, _, _, _, state, _, _, postcode]) do
      %{
        latitude: latitude,
        longitude: longitude,
        name: name,
        postcode: postcode,
        state: state
      }
    end

    defp parse_illumination_sample_row([_, _, day, hour, beam, diffuse, bulb_temp | _]) do
      {beam, _} = Float.parse(beam)
      {diffuse, _} = Float.parse(diffuse)
      {bulb_temp, _} = Float.parse(bulb_temp)

      %{
        day: String.to_integer(day),
        hour: String.to_integer(hour),
        beam: beam,
        diffuse: diffuse,
        bulb_temp: bulb_temp
      }
    end

    # Number of half-hours per year
    defp intervals_per_year, do: 365 * 24 * 2
  end

  defmodule Loader do
    alias Ecto.Multi
    alias Sunulator.Repo
    alias Sunulator.Locations.{Location, Illumination}

    def insert(stream) do
      stream
      |> Stream.with_index()
      |> Stream.map(fn {{location, illuminations}, index} ->
        key = "location:#{index}"

        Multi.new()
        |> Multi.insert(key, Location.changeset(%Location{}, location))
        |> Multi.merge(fn %{^key => location} ->
          illuminations
          |> Stream.flat_map(fn illumination ->
            [Map.put(illumination, :location_id, location.id)]
          end)
          |> Stream.chunk_every(7_000)
          |> Stream.with_index()
          |> Stream.map(fn {illuminations, index} ->
            Multi.insert_all(Multi.new(), {:illuminations, index}, Illumination, illuminations)
          end)
          |> Enum.reduce(Multi.new(), &Multi.append/2)
        end)
      end)
      |> Stream.each(&Repo.transaction/1)
      |> Stream.run()
    end
  end

  def load(file) do
    file
    |> CSVParser.parse()
    |> Loader.insert()
  end
end
