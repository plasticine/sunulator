defmodule Sunulator.Locations.Region do
  use Sunulator.Schema
  import Ecto.Changeset

  schema "regions" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
