# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

# NimbleCSV.define(LocationDataCSV, separator: ",", escape: "\"")

# defmodule LocationDataParser do
#   @moduledoc """
#   These CSV data files are of the following structure;

#   >>> location header
#   ... location row 1
#   ... location row n
#   >>> data header
#   ... location row 1 data row 1
#   ... location row 1 data row 17_520
#   ... location row 2 data row 1
#   ... location row 2 data row 17_520
#   """

#   defmodule Location do
#     defstruct [:name, :latitude, :longitude, :state, :postcode, :elevation]

#     def from_data!({:data, data}), do: from_data!(data)

#     def from_data!([_, name, _, _, latitude, longitude, _, _, _, state, _, _, postcode]) do
#       %__MODULE__{
#         name: name,
#         latitude: to_float(latitude),
#         longitude: to_float(longitude),
#         state: state,
#         postcode: String.to_integer(postcode),
#         elevation: 0,
#       }
#     end

#     defp to_float(binary) when is_binary(binary), do: to_float(Float.parse(binary))
#     defp to_float({float, ""}), do: float
#   end

#   defmodule LocationData do
#     defstruct [:year, :month, :day, :hour, :beam, :diffuse, :tdry]

#     def from_data!({:data, data}), do: from_data!(data)

#     def from_data!([year, month, day, hour, beam, diffuse, tdry | _]) do
#       %__MODULE__{
#         year: String.to_integer(year),
#         month: String.to_integer(month),
#         day: String.to_integer(day),
#         hour: String.to_integer(hour),
#         beam: String.to_integer(beam),
#         diffuse: String.to_integer(diffuse),
#         tdry: to_float(tdry)
#       }
#     end

#     defp to_float(binary) when is_binary(binary), do: to_float(Float.parse(binary))
#     defp to_float({float, ""}), do: float
#   end

#   def parse do
#     Path.wildcard(Path.join(Path.dirname(__DIR__), "repo/data/nsw.csv"))
#     |> Enum.map(fn file ->
#       file
#       |> stream_file
#       |> Flow.from_enumerable()
#       |> Flow.partition()
#       |> Flow.map(fn item ->
#         item
#       end)
#       |> Flow.run()
#     end)
#     |> IO.inspect
#   end

#   defp stream_file(file) do
#     file
#     |> File.stream!()
#     |> LocationDataCSV.parse_stream(skip_headers: false)
#   end

#   defp parse_stream(stream) do
#     stream
#     # Parse each line
#     |> Stream.flat_map(&parse_line/1)
#     # Chunk by header groups
#     |> Stream.chunk_by(&header?/1)
#     # Chunk each set of data with it’s respective header
#     |> Stream.chunk_every(2)
#     # Actually parse the data to structs
#     |> Stream.flat_map(fn
#       [[header: [type: :location]], data] -> Stream.map(data, &Location.from_data!/1)
#       [[header: [type: :data]], data] -> Stream.map(data, &LocationData.from_data!/1)
#     end)
#     # Chunk by the type
#     |> Stream.chunk_by(fn
#       %Location{} -> :location
#       %LocationData{} -> :data
#     end)
#     # Split the locations from the data
#     |> StreamSplit.pop
#     # Chunk the data and zip it back with the locations
#     |> case do
#       {locations, location_data} ->
#         location_data = Stream.flat_map(location_data, fn x -> Stream.chunk_every(x, 17_520) end)
#         locations = Stream.zip(locations, location_data)

#         # {:ok, _} = Sunulator.Repo.transaction fn ->
#         #   Enum.each(locations, fn {location, _} ->
#         #     Sunulator.Locations.create_location(%{
#         #       name: location.name,
#         #       elevation: location.elevation,
#         #       latitude: location.latitude,
#         #       longitude: location.longitude,
#         #       name: location.name,
#         #       postcode: location.postcode,
#         #       state: location.state,
#         #     })
#         #   end)
#         # end
#     end
#   end

#   defp header?({:header, _}), do: true
#   defp header?({:data, _}), do: false

#   defp parse_line(line) do
#     case line do
#       # Location header line
#       ["Location", "City", "Region" | _] -> [{:header, type: :location}]
#       # Location data header line
#       ["Year", "Month", "Day" | _] -> [{:header, type: :data}]
#       # Any other line is data!
#       _ -> [{:data, line}]
#     end
#   end
# end

alias Sunulator.Locations.Location

Location.CSVParser.parse_files(Path.wildcard(Path.join(Path.dirname(__DIR__), "repo/data/nsw.csv")))
