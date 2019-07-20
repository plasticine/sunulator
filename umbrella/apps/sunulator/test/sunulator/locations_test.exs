defmodule Sunulator.LocationsTest do
  use Sunulator.DataCase

  alias Sunulator.Locations

  describe "regions" do
    alias Sunulator.Locations.Region

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def region_fixture(attrs \\ %{}) do
      {:ok, region} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_region()

      region
    end

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Locations.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Locations.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      assert {:ok, %Region{} = region} = Locations.create_region(@valid_attrs)
      assert region.name == "some name"
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      assert {:ok, %Region{} = region} = Locations.update_region(region, @update_attrs)
      assert region.name == "some updated name"
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_region(region, @invalid_attrs)
      assert region == Locations.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Locations.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Locations.change_region(region)
    end
  end

  describe "locations" do
    alias Sunulator.Locations.Location

    @valid_attrs %{elevation: 120.5, latitude: 120.5, longitude: 120.5, name: "some name", postcode: 42, state: "some state"}
    @update_attrs %{elevation: 456.7, latitude: 456.7, longitude: 456.7, name: "some updated name", postcode: 43, state: "some updated state"}
    @invalid_attrs %{elevation: nil, latitude: nil, longitude: nil, name: nil, postcode: nil, state: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Locations.create_location(@valid_attrs)
      assert location.elevation == 120.5
      assert location.latitude == 120.5
      assert location.longitude == 120.5
      assert location.name == "some name"
      assert location.postcode == 42
      assert location.state == "some state"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Locations.update_location(location, @update_attrs)
      assert location.elevation == 456.7
      assert location.latitude == 456.7
      assert location.longitude == 456.7
      assert location.name == "some updated name"
      assert location.postcode == 43
      assert location.state == "some updated state"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
