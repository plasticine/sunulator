defmodule Sunulator.Locations.Sample.SunTest do
  use ExUnit.Case, async: true
  alias Sunulator.Locations.Sample.Sun

  test "equation_of_time/1 calculates the equation of time" do
    assert Sun.equation_of_time(day: 1) == -3.7051783233960682
    assert Sun.equation_of_time(day: 91) == -4.344296101151456
    assert Sun.equation_of_time(day: 182) == -3.4722852044709
    assert Sun.equation_of_time(day: 365) == -3.2562349238053425
  end

  test "time_correction_factor/1 calculates the time correction factor" do
    assert_raise ArgumentError, "Day should be between 1 and 365", fn -> Sun.declination(day: 0) end
    assert_raise ArgumentError, "Day should be between 1 and 365", fn -> Sun.declination(day: 366) end

    assert Sun.time_correction_factor(day: 1, longitude: 144.9631, time_zone_offset: 10) == -23.85277832339608
  end

  test "declination/1 calculates the declination angle of sun in degrees" do
    assert_raise ArgumentError, "Day should be between 1 and 365", fn -> Sun.declination(day: 0) end
    assert_raise ArgumentError, "Day should be between 1 and 365", fn -> Sun.declination(day: 366) end

    assert Sun.declination(day: 1) == -23.011636727869238
    assert Sun.declination(day: 91) == 4.016824231055649
    assert Sun.declination(day: 182) == 23.120484116651824
    assert Sun.declination(day: 365) == -23.085911002836564
  end

  test "interval_local_solar_time/1 calculates local solar time for a given interval and time correction" do
    assert_raise ArgumentError, "Interval should be between 1 and 48", fn -> Sun.interval_local_solar_time(interval: 0, time_correction_factor: 0) end
    assert_raise ArgumentError, "Interval should be between 1 and 48", fn -> Sun.interval_local_solar_time(interval: 49, time_correction_factor: 0) end

    assert Sun.interval_local_solar_time(interval: 1, time_correction_factor: 0) == 0.5
    assert Sun.interval_local_solar_time(interval: 24, time_correction_factor: 0) == 12 # noon
    assert Sun.interval_local_solar_time(interval: 48, time_correction_factor: 0) == 24.0
    assert Sun.interval_local_solar_time(interval: 1, time_correction_factor: -4.2) == 0.43
    assert Sun.interval_local_solar_time(interval: 24, time_correction_factor: -4.2) == 11.93
    assert Sun.interval_local_solar_time(interval: 48, time_correction_factor: -4.2) == 23.93
  end

  test "hour_angle/1 calculates solar time expressed as an angle" do
    assert Sun.hour_angle(local_solar_time: 0) == -180
    assert Sun.hour_angle(local_solar_time: 12) == 0
    assert Sun.hour_angle(local_solar_time: 24) == 180
  end

  test "elevation/1 calculates the elevation angle of the sun" do
    assert Sun.elevation(latitude: -37.8075, declination: Sun.declination(day: 1), local_solar_time: 1) == -27.567234447953936
    # assert Sun.elevation(latitude: -37.8075, declination: declination, local_solar_time: 6) == 13.908267157600413
    # assert Sun.elevation(latitude: -37.8075, declination: declination, local_solar_time: 12) == 75.27841100283658
  end
end
