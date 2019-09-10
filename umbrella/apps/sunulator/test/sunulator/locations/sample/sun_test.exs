defmodule Sunulator.Locations.Sample.SunTest do
  use ExUnit.Case, async: true
  alias Sunulator.Locations.Sample.Sun

  describe "time_correction" do
    test "time_correction/3 calculates the time correction factor" do
      assert Sun.time_correction(day: 1, longitude: 150, time_zone_offset: 10) == -3.7051783233960682
    end
  end
end
