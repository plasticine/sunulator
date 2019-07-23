defmodule Sunulator.Locations.Location do
  use Sunulator.Schema
  import Ecto.Changeset
  alias Sunulator.Locations.Illumination

  schema "locations" do
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :postcode, :integer
    field :state, :string

    has_many :illuminations, Illumination

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :latitude, :longitude, :state, :postcode])
    |> validate_required([:name, :latitude, :longitude, :state, :postcode])
  end
end
