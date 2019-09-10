defmodule Sunulator.Fixtures.Locations.Sample do
  @moduledoc """
  Create a fixture Sample.
  """

  use Sunulator.Fixtures.Fixture
  alias Sunulator.Locations.Sample

  def create(attrs \\ %{}) do
    location = Map.get(attrs, :location, Fixtures.Locations.Location.insert!())
    day = Map.get(attrs, :day, Faker.random_between(1, 365))
    interval = Map.get(attrs, :interval, Faker.random_between(1, 48))
    interval_type = Map.get(attrs, :interval_type, :half_hour)
    diffuse = Map.get(attrs, :diffuse, 120.5)
    beam = Map.get(attrs, :beam, 456.7)
    bulb_temp = Map.get(attrs, :bulb_temp, 30.2)

    %Sample{
      location: location,
      day: day,
      interval: interval,
      interval_type: interval_type,
      diffuse: diffuse,
      beam: beam,
      bulb_temp: bulb_temp,
    }
  end
end
