# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Sunulator.Locations.Sample

Path.join(Path.dirname(__DIR__), "locations/data/*.csv")
|> Path.wildcard()
|> Sample.Loader.load()
