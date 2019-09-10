defmodule Sunulator.Simulations.Scenario do
  use Sunulator.Schema
  import Ecto.Changeset
  alias Sunulator.Simulations.Scenario

  schema "scenarios" do
    field :name, :string

    belongs_to :location, Sunulator.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(scenario, attrs) do
    scenario
    |> cast(attrs, [:name, :location_id])
    |> validate_required([:name, :location_id])
    |> foreign_key_constraint(:location_id)
  end

  def run!(scenario) do
    # This will probably become a background job type thing later
    Scenario.Runner.run!(scenario.id)
  end
end
