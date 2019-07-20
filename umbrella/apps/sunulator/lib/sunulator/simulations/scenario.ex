defmodule Sunulator.Simulations.Scenario do
  use Sunulator.Schema
  import Ecto.Changeset

  schema "scenarios" do
    field :name, :string
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(scenario, attrs) do
    scenario
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
