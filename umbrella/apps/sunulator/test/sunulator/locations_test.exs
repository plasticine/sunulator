defmodule Sunulator.LocationsTest do
  use Sunulator.DataCase
  alias Sunulator.Fixtures
  alias Sunulator.Locations

  describe "locations" do
    alias Locations.Location

    @valid_attrs %{latitude: 120.5, longitude: 120.5, longitude_ref: 120, time_zone_offset: 10.0, name: "some name", postcode: "42", state: "some state"}
    @update_attrs %{latitude: 456.7, longitude: 456.7, longitude_ref: 150, time_zone_offset: 9.0, name: "some updated name", postcode: "43", state: "some updated state"}
    @invalid_attrs %{latitude: nil, longitude: nil, name: nil, postcode: nil, state: nil, longitude_ref: nil, time_zone_offset: nil}

    test "list_locations/0 returns all locations" do
      location = Fixtures.Locations.Location.insert!()
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = Fixtures.Locations.Location.insert!()
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Locations.create_location(@valid_attrs)
      assert location.latitude == 120.5
      assert location.longitude == 120.5
      assert location.longitude_ref == 120
      assert location.name == "some name"
      assert location.postcode == "42"
      assert location.state == "some state"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = Fixtures.Locations.Location.insert!()
      assert {:ok, %Location{} = location} = Locations.update_location(location, @update_attrs)
      assert location.latitude == 456.7
      assert location.longitude == 456.7
      assert location.longitude_ref == 150
      assert location.name == "some updated name"
      assert location.postcode == "43"
      assert location.state == "some updated state"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = Fixtures.Locations.Location.insert!()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = Fixtures.Locations.Location.insert!()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = Fixtures.Locations.Location.insert!()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end

  describe "samples" do
    alias Sunulator.Locations.Sample
    alias Ecto.Association.NotLoaded

    @valid_attrs %{interval_type: :half_hour, beam: 120.5, bulb_temp: 120.5, day: 42, diffuse: 120.5, interval: 42}
    @update_attrs %{interval_type: :half_hour, beam: 456.7, bulb_temp: 456.7, day: 43, diffuse: 456.7, interval: 43}
    @invalid_attrs %{interval_type: :half_hour, beam: nil, bulb_temp: nil, day: nil, diffuse: nil, interval: nil}

    test "list_samples/0 returns all samples" do
      sample =
        Fixtures.Locations.Sample.insert!()
        |> Map.put(:location, %NotLoaded{__field__: :location, __cardinality__: :one, __owner__: Sample})
      assert Locations.list_samples() == [sample]
    end

    test "get_sample!/1 returns the sample with given id" do
      sample =
        Fixtures.Locations.Sample.insert!()
        |> Map.put(:location, %NotLoaded{__field__: :location, __cardinality__: :one, __owner__: Sample})
      assert Locations.get_sample!(sample.id) == sample
    end

    test "create_sample/1 with valid data creates a sample" do
      location = Fixtures.Locations.Location.insert!
      valid_attrs = Map.put(@valid_attrs, :location_id, location.id)
      assert {:ok, %Sample{} = sample} = Locations.create_sample(valid_attrs)
      assert sample.interval_type == :half_hour
      assert sample.beam == 120.5
      assert sample.bulb_temp == 120.5
      assert sample.day == 42
      assert sample.diffuse == 120.5
      assert sample.interval == 42
    end

    test "create_sample/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_sample(@invalid_attrs)
    end

    test "update_sample/2 with valid data updates the sample" do
      sample = Fixtures.Locations.Sample.insert!()
      {:ok, %Sample{} = sample} = Locations.update_sample(sample, @update_attrs)
      sample = Map.put(sample, :location, %NotLoaded{__field__: :location, __cardinality__: :one, __owner__: Sample})

      assert sample.interval_type == :half_hour
      assert sample.beam == 456.7
      assert sample.bulb_temp == 456.7
      assert sample.day == 43
      assert sample.diffuse == 456.7
      assert sample.interval == 43
    end

    test "update_sample/2 with invalid data returns error changeset" do
      sample =
        Fixtures.Locations.Sample.insert!()
        |> Map.put(:location, %NotLoaded{__field__: :location, __cardinality__: :one, __owner__: Sample})
      assert {:error, %Ecto.Changeset{}} = Locations.update_sample(sample, @invalid_attrs)
      assert sample == Locations.get_sample!(sample.id)
    end

    test "delete_sample/1 deletes the sample" do
      sample = Fixtures.Locations.Sample.insert!()
      assert {:ok, %Sample{}} = Locations.delete_sample(sample)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_sample!(sample.id) end
    end

    test "change_sample/1 returns a sample changeset" do
      sample = Fixtures.Locations.Sample.insert!()
      assert %Ecto.Changeset{} = Locations.change_sample(sample)
    end
  end
end
