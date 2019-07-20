defmodule Sunulator.Locations.Location do
  use Sunulator.Schema
  import Ecto.Changeset

  schema "locations" do
    field :elevation, :float
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :postcode, :integer
    field :state, :string
    field :region_id, :id

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :latitude, :longitude, :elevation, :state, :postcode])
    |> validate_required([:name, :latitude, :longitude, :elevation, :state, :postcode])
  end
end
