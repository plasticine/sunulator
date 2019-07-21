# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sunulator.Repo.insert!(%Sunulator.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

NimbleCSV.define(LocationDataCSV, separator: ",", escape: "\"")

defmodule LocationDataParser do
  defmodule Location do
    defstruct [:name, :latitude, :longitude, :state, :postcode]

    def from_data!({:data, data}), do: from_data!(data)

    def from_data!([_, name, _, _, latitude, longitude, _, _, _, state, _, _, postcode]) do
      %__MODULE__{
        name: name,
        latitude: Float.parse(latitude),
        longitude: Float.parse(longitude),
        state: state,
        postcode: String.to_integer(postcode)
      }
    end
  end

  defmodule LocationData do
    defstruct [:year, :month, :day, :hour, :beam, :diffuse, :tdry]

    def from_data!({:data, data}), do: from_data!(data)

    def from_data!([year, month, day, hour, beam, diffuse, tdry | _]) do
      %__MODULE__{
        year: String.to_integer(year),
        month: String.to_integer(month),
        day: String.to_integer(day),
        hour: String.to_integer(hour),
        beam: String.to_integer(beam),
        diffuse: String.to_integer(diffuse),
        tdry: Float.parse(tdry)
      }
    end
  end

  def parse do
    Path.wildcard(Path.join(Path.dirname(__DIR__), "repo/data/*.csv"))
    |> Enum.take(1)
    |> Enum.map(&parse_file/1)
    |> Enum.at(0)
    |> IO.inspect()
  end

  defp parse_file(file) do
    [locations | location_data] =
      file
      |> File.stream!()
      |> LocationDataCSV.parse_stream(skip_headers: false)
      # Parse each line
      |> Stream.map(&parse_line/1)
      # Chunk by header groups
      |> Stream.chunk_by(&header?/1)
      # Chunk each set of data with it’s respective header
      |> Stream.chunk_every(2)
      |> Stream.map(fn [[header: [type: type]], data] ->
        case type do
          :location -> Enum.map(data, &Location.from_data!/1)
          :location_data -> Enum.map(data, &LocationData.from_data!/1)
        end
      end)
      |> Enum.to_list()

    Enum.zip(locations, location_data)
  end

  defp header?({:header, _}), do: true
  defp header?({:data, _}), do: false

  defp parse_line(line) do
    case line do
      # Location header line
      ["Location", "City", "Region" | _] -> {:header, type: :location}
      # Location data header line
      ["Year", "Month", "Day" | _] -> {:header, type: :location_data}
      # Any other line is data!
      _ -> {:data, line}
    end
  end
end

LocationDataParser.parse()
