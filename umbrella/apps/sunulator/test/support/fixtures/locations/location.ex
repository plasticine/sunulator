defmodule Sunulator.Fixtures.Locations.Location do
  @moduledoc """
  Create a fixture Location.
  """

  use Sunulator.Fixtures.Fixture
  alias Sunulator.Locations.Location

  def create(attrs \\ %{}) do
    name = Map.get(attrs, :name, Faker.Address.city())
    latitude = Map.get(attrs, :latitude, Faker.Address.latitude())
    longitude = Map.get(attrs, :longitude, Faker.Address.longitude())
    postcode = Map.get(attrs, :postcode, Faker.Address.postcode())

    %Location{
      name: name,
      latitude: latitude,
      longitude: longitude,
      longitude_ref: longitude,
      postcode: postcode,
      time_zone_offset: 10.0,
      state: "some state"
    }
  end
end
