defmodule Sunulator.LocationsTest do
  use Sunulator.DataCase

  alias Sunulator.Locations

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

  describe "illuminations" do
    alias Sunulator.Locations.Illumination

    @valid_attrs %{beam: 120.5, bulb_temp: 120.5, day: 42, diffuse: 120.5, month: 42, sample_date: ~N[2010-04-17 14:00:00], year: 42}
    @update_attrs %{beam: 456.7, bulb_temp: 456.7, day: 43, diffuse: 456.7, month: 43, sample_date: ~N[2011-05-18 15:01:01], year: 43}
    @invalid_attrs %{beam: nil, bulb_temp: nil, day: nil, diffuse: nil, month: nil, sample_date: nil, year: nil}

    def illumination_fixture(attrs \\ %{}) do
      {:ok, illumination} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_illumination()

      illumination
    end

    test "list_illuminations/0 returns all illuminations" do
      illumination = illumination_fixture()
      assert Locations.list_illuminations() == [illumination]
    end

    test "get_illumination!/1 returns the illumination with given id" do
      illumination = illumination_fixture()
      assert Locations.get_illumination!(illumination.id) == illumination
    end

    test "create_illumination/1 with valid data creates a illumination" do
      assert {:ok, %Illumination{} = illumination} = Locations.create_illumination(@valid_attrs)
      assert illumination.beam == 120.5
      assert illumination.bulb_temp == 120.5
      assert illumination.day == 42
      assert illumination.diffuse == 120.5
      assert illumination.month == 42
      assert illumination.sample_date == ~N[2010-04-17 14:00:00]
      assert illumination.year == 42
    end

    test "create_illumination/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_illumination(@invalid_attrs)
    end

    test "update_illumination/2 with valid data updates the illumination" do
      illumination = illumination_fixture()
      assert {:ok, %Illumination{} = illumination} = Locations.update_illumination(illumination, @update_attrs)
      assert illumination.beam == 456.7
      assert illumination.bulb_temp == 456.7
      assert illumination.day == 43
      assert illumination.diffuse == 456.7
      assert illumination.month == 43
      assert illumination.sample_date == ~N[2011-05-18 15:01:01]
      assert illumination.year == 43
    end

    test "update_illumination/2 with invalid data returns error changeset" do
      illumination = illumination_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_illumination(illumination, @invalid_attrs)
      assert illumination == Locations.get_illumination!(illumination.id)
    end

    test "delete_illumination/1 deletes the illumination" do
      illumination = illumination_fixture()
      assert {:ok, %Illumination{}} = Locations.delete_illumination(illumination)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_illumination!(illumination.id) end
    end

    test "change_illumination/1 returns a illumination changeset" do
      illumination = illumination_fixture()
      assert %Ecto.Changeset{} = Locations.change_illumination(illumination)
    end
  end
end
