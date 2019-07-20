defmodule Sunulator.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float
      add :elevation, :float
      add :state, :string
      add :postcode, :integer
      add :region_id, references(:regions, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:region_id])
  end
end
