defmodule Sunulator.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float
      add :state, :string
      add :postcode, :integer

      timestamps()
    end
  end
end
