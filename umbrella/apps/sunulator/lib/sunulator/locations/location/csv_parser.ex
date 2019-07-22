defmodule Sunulator.Locations.Location.CSVParser do
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

  alias Sunulator.Locations.Location

  NimbleCSV.define(CSVParser, separator: ",", escape: "\"")

  # defmodule IlluminationLocation do
  #   defstruct [:name, :latitude, :longitude, :state, :postcode, :elevation]
  # end

  defmodule IlluminationSample do
    defstruct [:year, :month, :day, :hour, :beam, :diffuse, :tdry]
  end

  def parse_files(files) when is_list(files) do
    files
    |> Enum.map(&stream_file!/1)
    |> Enum.map(&parse_stream/1)
    |> Enum.map(&insert!/1)

    |> Enum.to_list()
    |> IO.inspect()

    # |> Flow.partition()
    # |> Flow.reduce(&Ecto.Multi.new/0, fn
    #   [location, illumination_data], multi ->
    #     Ecto.Multi.insert(:log, location)
    # end)

    # |> IO.inspect

    # |> Flow.map(&parse_stream/1)

    # |> Flow.map(&parse_row_types/1)
    # |> Flow.reduce(fn -> [] end, fn row, memo ->
    #   List.insert_at(memo, 0, row)
    # end)
  end

  defp insert!(stream) do
    stream
    |> Enum.reduce(Ecto.Multi.new, fn [location, illumination], multi ->
      Ecto.Multi.insert(multi, :log, location)
    end)
    |> Sunulator.Repo.transaction()
  end

  defp stream_file!(file) do
    file
    |> File.stream!(read_ahead: 100_000)
    |> CSVParser.parse_stream(skip_headers: true)
  end

  defp parse_stream(stream) do
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
          |> Stream.chunk_every(17_520)

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
    %Location{
      elevation: 0,
      latitude: to_float(latitude),
      longitude: to_float(longitude),
      name: name,
      postcode: to_integer(postcode),
      state: state
    }
  end

  defp parse_illumination_sample_row([year, month, day, hour, beam, diffuse, tdry | _]) do
    %IlluminationSample{
      year: to_integer(year),
      month: to_integer(month),
      day: to_integer(day),
      hour: to_integer(hour),
      beam: to_integer(beam),
      diffuse: to_integer(diffuse),
      tdry: to_float(tdry)
    }
  end

  def to_float(binary) when is_binary(binary), do: to_float(Float.parse(binary))
  def to_float({float, _}), do: float

  def to_integer(binary) when is_binary(binary), do: String.to_integer(binary)
end
