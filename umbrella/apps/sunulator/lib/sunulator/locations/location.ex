defmodule Sunulator.Locations.Location do
  use Sunulator.Schema
  import Ecto.Changeset
  alias Sunulator.Locations.Sample

  schema "locations" do
    field :latitude, :float
    field :longitude, :float
    field :longitude_ref, :float
    field :time_zone_offset, :float
    field :name, :string
    field :postcode, :string
    field :state, :string

    has_many :samples, Sample

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [
      :name,
      :latitude,
      :longitude,
      :longitude_ref,
      :time_zone_offset,
      :state,
      :postcode
    ])
    |> validate_required([
      :name,
      :latitude,
      :longitude,
      :longitude_ref,
      :time_zone_offset,
      :state,
      :postcode
    ])
  end
end
