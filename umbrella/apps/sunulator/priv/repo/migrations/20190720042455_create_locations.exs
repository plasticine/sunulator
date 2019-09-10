defmodule Sunulator.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float
      add :longitude_ref, :float
      add :time_zone_offset, :float
      add :state, :string
      add :postcode, :string

      timestamps()
    end
  end
end
