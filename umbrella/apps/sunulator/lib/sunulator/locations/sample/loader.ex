defmodule Sunulator.Locations.Sample.Loader do
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

  defmodule Parser do
    alias alias Sunulator.Locations.Sample

    NimbleCSV.define(CSVParser, separator: ",", escape: "\"")

    def parse(file) do
      IO.puts("Parsing #{file}")

      file
      |> stream_rows
      |> parse_rows
    end

    defp stream_rows(file) do
      file
      |> File.stream!(read_ahead: 100_000)
      |> CSVParser.parse_stream(skip_headers: true)
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
        {locations, samples} ->
          locations =
            locations
            |> Stream.map(&parse_location_row/1)

          samples =
            samples
            |> Stream.flat_map(fn x -> x end)
            |> Stream.map(&parse_sample_row/1)
            |> Stream.chunk_every(intervals_per_year())

          Stream.zip(locations, samples)
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

    defp parse_location_row([
           _location,
           name,
           _region,
           _country,
           latitude,
           longitude,
           time_zone_offset,
           _elevation,
           _source,
           state,
           longitude_ref,
           _cal_factor,
           postcode
         ]) do
      %{
        latitude: latitude,
        longitude: longitude,
        longitude_ref: longitude_ref,
        time_zone_offset: time_zone_offset,
        name: name,
        postcode: postcode,
        state: state
      }
    end

    defp parse_sample_row([_, _, day, interval, beam, diffuse, bulb_temp | _]) do
      {beam, _} = Float.parse(beam)
      {diffuse, _} = Float.parse(diffuse)
      {bulb_temp, _} = Float.parse(bulb_temp)

      %{
        day: String.to_integer(day),
        interval: String.to_integer(interval),
        interval_type: :half_hour,
        beam: beam,
        diffuse: diffuse,
        bulb_temp: bulb_temp
      }
    end

    # Number of half-hour intervals per year
    defp intervals_per_year, do: 365 * 24 * 2
  end

  defmodule Loader do
    alias Ecto.Multi
    alias Sunulator.Repo
    alias Sunulator.Locations.{Location, Sample}

    def load(stream) do
      stream
      |> Stream.with_index()
      |> Stream.map(fn {{location, samples}, index} ->
        key = "location:#{index}"

        Multi.new()
        |> Multi.insert(key, Location.changeset(%Location{}, location))
        |> Multi.merge(fn %{^key => location} ->
          samples
          |> Stream.flat_map(fn illumination ->
            [Map.put(illumination, :location_id, location.id)]
          end)
          |> Stream.chunk_every(7_000)
          |> Stream.with_index()
          |> Stream.map(fn {samples, index} ->
            Multi.insert_all(Multi.new(), {:samples, index}, Sample, samples)
          end)
          |> Enum.reduce(Multi.new(), &Multi.append/2)
        end)
      end)
      |> Stream.each(&Repo.transaction/1)
      |> Stream.run()
    end
  end

  def load(files) when is_list(files) do
    Logger.remove_backend(:console)

    files
    |> Enum.map(fn file -> Task.async(fn -> load(file) end) end)
    |> Enum.map(fn task -> Task.await(task, 60_000) end)
    |> IO.inspect()
  end

  def load(file) do
    file
    |> Parser.parse()
    |> Loader.load()
  end
end
