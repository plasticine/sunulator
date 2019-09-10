defmodule Sunulator.Fixtures.Simulations.Scenario do
  @moduledoc """
  Create a fixture Scenario.
  """

  use Sunulator.Fixtures.Fixture
  alias Sunulator.Simulations.Scenario

  def create(attrs \\ %{}) do
    name = Map.get(attrs, :name, Faker.Superhero.name())
    location = Map.get(attrs, :location, Fixtures.Locations.Location.insert!())

    %Scenario{
      name: name,
      location: location,
    }
  end
end
