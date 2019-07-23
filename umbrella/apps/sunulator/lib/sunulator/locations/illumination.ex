defmodule Sunulator.Locations.Illumination do
  use Sunulator.Schema
  import Ecto.Changeset
  alias Sunulator.Locations.Location

  schema "illuminations" do
    field :day, :integer
    field :hour, :integer
    field :diffuse, :float
    field :beam, :float
    field :bulb_temp, :float

    belongs_to :location, Location
  end

  @doc false
  def changeset(illumination, attrs) do
    illumination
    |> cast(attrs, [:day, :hour, :beam, :diffuse, :bulb_temp, :location_id])
    |> validate_required([:day, :hour, :beam, :diffuse, :bulb_temp, :location_id])
    |> foreign_key_constraint(:location_id)
  end
end
