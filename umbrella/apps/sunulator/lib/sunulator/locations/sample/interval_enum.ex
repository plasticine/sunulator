defmodule Sunulator.Locations.Sample.IntervalEnum do
  use EctoEnum.Postgres, type: :sample_interval, enums: [:half_hour]
end
