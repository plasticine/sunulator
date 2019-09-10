defmodule Sunulator.Simulations.Scenario.Runner do
  import Ecto.Query, only: [from: 2]
  alias Sunulator.Repo
  alias Sunulator.Simulations.Scenario
  alias Sunulator.Locations.{Location,Sample}

  def run!(scenario_id) do
    scenario = Repo.one! from scenario in Scenario,
      where: scenario.id == ^scenario_id,
      left_join: location in assoc(scenario, :location),
      left_join: samples in assoc(location, :samples),
      order_by: [samples.day, samples.interval],
      preload: [location: {location, samples: {samples, location: location}}]

    Enum.map(scenario.location.samples, fn sample ->
      {:ok, position} = Sample.Sun.status(sample)

      IO.inspect position

      Map.take(sample, [:day, :interval, :interval_type])
    end)


    # :ok

    # scenario.location.illuminations
    # |> Enum.map(fn illumination ->
    #   sun = illumination
    #     |> Scenario.Sun.status
    #     |> IO.inspect
    # end)
  end
end
