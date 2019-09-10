defmodule Sunulator.Locations.Sample do
  use Sunulator.Schema
  import Ecto.Changeset
  alias Sunulator.Locations.Sample
  alias Sunulator.Locations.Location

  schema "samples" do
    field :day, :integer
    field :interval, :integer
    field :interval_type, Sample.IntervalEnum
    field :diffuse, :float
    field :beam, :float
    field :bulb_temp, :float

    belongs_to :location, Location
  end

  @doc false
  def changeset(sample, attrs) do
    sample
    |> cast(attrs, [:day, :interval, :interval_type, :beam, :diffuse, :bulb_temp, :location_id])
    |> validate_required([:day, :interval, :interval_type, :beam, :diffuse, :bulb_temp, :location_id])
    |> foreign_key_constraint(:location_id)
  end
end
