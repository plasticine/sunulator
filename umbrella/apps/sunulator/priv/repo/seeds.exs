# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Sunulator.Locations.Location.IlluminationLoader

Path.join(Path.dirname(__DIR__), "locations/data/*.csv")
|> Path.wildcard()
|> Enum.map(&IlluminationLoader.load/1)
