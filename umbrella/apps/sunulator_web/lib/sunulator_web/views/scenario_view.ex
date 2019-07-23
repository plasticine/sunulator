defmodule SunulatorWeb.ScenarioView do
  use SunulatorWeb, :view
  import Ecto.Query, warn: false

  def locations do
    p in Sunulator.Locations.Location
    |> from(select: {p.name, p.id})
    |> Sunulator.Repo.all
  end
end
