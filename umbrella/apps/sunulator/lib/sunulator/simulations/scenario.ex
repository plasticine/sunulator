defmodule Sunulator.Simulations.Scenario do
  use Sunulator.Schema
  import Ecto.Changeset

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
end
