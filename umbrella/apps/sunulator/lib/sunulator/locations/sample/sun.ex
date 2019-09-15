defmodule Sunulator.Locations.Sample.Sun do
  @moduledoc """
  This module provides Sun calculation functions for working with Samples.

  At the moment it assumes way too much about the interval type (i.e that it’s 30mins).

  References:

    - https://www.pveducation.org/pvcdrom/properties-of-sunlight/solar-time
    - https://github.com/trautsned/photovoltaic/blob/master/photovoltaic/sun.py
  """

  alias Sunulator.Math
  alias Sunulator.Locations.Sample

  @doc """
  For a given Sample, calculate the sun's position in the sky.
  """
  def status(%Sample{} = sample) do
    time_correction_factor = time_correction_factor(day: sample.day, longitude: sample.location.longitude, time_zone_offset: sample.location.time_zone_offset)
    # local_solar_time = local_solar_time(interval: sample.interval, time_correction_factor: time_correction_factor)
    # hour_angle = hour_angle(local_solar_time: local_solar_time)
    # declination = declination(day: sample.day)
    # elevation = elevation(latitude: sample.location.latitude, declination: declination, hour_angle: hour_angle)
    # azimuth = azimuth(latitude: sample.location.latitude, declination: declination, elevation: elevation, hour_angle: hour_angle)
    # sunrise = sunrise(latitude: sample.location.latitude, declination: declination, time_correction_factor: time_correction_factor)
    # sunset = sunset(latitude: sample.location.latitude, declination: declination, time_correction_factor: time_correction_factor)

    {:ok, %{
      time_correction_factor: time_correction_factor,
      # local_solar_time: local_solar_time,
      # hour_angle: hour_angle,
      # declination: declination,
      # elevation: elevation,
      # azimuth: azimuth,
      # sunrise: sunrise,
      # sunset: sunset
    }}
  end

  @doc """

  """
  def equation_of_time(day) do
    b = 360.0 / 365.0 * (day - 81.0)
    9.87 * Math.sind(2 * b) - 7.53 * Math.cosd(b) - 1.5 * Math.sind(b)
  end

  @doc """
  Time Correction Factor is the time in minutes which accounts for the variation in Local Solar Time
  (LST) within a timezone due to longitude variations within the time zone, eccentricity of the
  Earth's orbit and the earth's axial tilt.

  The equation of time (EoT) (also minutes) is an empirical equation that corrects for the eccentricity
  of the Earth's orbit and the Earth's axial tilt.
  """
  def time_correction_factor(day: day, longitude: longitude, time_zone_offset: time_zone_offset) do
    validate_day!(day)

    # Calculate the LSTM
    local_standard_time_meridian = 360.0 / 24 * time_zone_offset
    # The factor of 4 minutes comes from the fact that the Earth rotates 1° every 4 minutes.
    4.0 * (longitude - local_standard_time_meridian) + equation_of_time(day)
  end

  @doc """
  Local solar time is a decimal number of hours, where hour 12 is noon.
  """
  def interval_local_solar_time(interval: interval, time_correction_factor: time_correction_factor) do
    validate_interval!(interval)

    total_minutes = interval * 30
    hours = :math.floor(total_minutes / 60)
    minutes = rem(total_minutes, 60)
    hours + (time_correction_factor + minutes) / 60.0
  end

  @doc """
  Hour Angle is the solar time expressed as an angle, where noon = 0 degrees. Each hour away from
  noon is 15 degrees; morning negative, afternoon positive.
  """
  def hour_angle(local_solar_time: local_solar_time) do
    (local_solar_time - 12.0) * 15.0
  end

  @doc """
  Return declination angle of sun in degrees for the give day of the year.
  Jan 1 day_no = 1, Dec 31 dayno = 365. There is no correction for leap years
  """
  def declination(day: day) do
    validate_day!(day)

    23.45 * Math.sind(360 / 365 * (day - 81))
  end

  @doc """
  Return the elevation angle of the sun given declination, latitude and local solar time.
  """
  def elevation(latitude: latitude, declination: declination, local_solar_time: local_solar_time) do
    hour_angle = hour_angle(local_solar_time: local_solar_time)
    Math.asind(Math.sind(declination) * Math.sind(latitude) + Math.cosd(declination) * Math.cosd(latitude) * Math.cosd(hour_angle))
  end

  @doc """
  Calculate azimuth of the sun from east to west. All values are in degrees, as is the azimuth.
  """
  def azimuth(latitude: latitude, declination: declination, elevation: elevation, hour_angle: hour_angle) do
    numerator = Math.sind(declination) * Math.cosd(latitude) - Math.cosd(declination) * Math.sind(latitude) * Math.cosd(hour_angle)
    denominator = Math.cosd(elevation)
    azimuth = Math.acosd(numerator / denominator)

    if hour_angle < 0 do
      azimuth # Before noon
    else
      360 - azimuth # After noon
    end
  end

  @doc """
  Time of sunrise as a fraction of a day.
  """
  def sunrise(latitude: latitude, declination: declination, time_correction_factor: time_correction_factor) do
    (12 - 1 / 15 * Math.acosd(-Math.tand(latitude) * Math.tand(declination)) - time_correction_factor / 60) / 24
  end

  @doc """
  Time of sunset as a fraction of a day.
  """
  def sunset(latitude: latitude, declination: declination, time_correction_factor: time_correction_factor) do
    (12 + 1 / 15 * Math.acosd(-Math.tand(latitude) * Math.tand(declination)) - time_correction_factor / 60) / 24
  end

  defp validate_day!(day) do
    if day < 1 || day > 365, do: raise ArgumentError, message: "Day should be between 1 and 365"
  end

  defp validate_interval!(interval) do
    if interval < 1 || interval > 48, do: raise ArgumentError, message: "Interval should be between 1 and 48"
  end
end
