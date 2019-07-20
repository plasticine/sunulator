defmodule Sunulator.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions) do
      add :name, :string

      timestamps()
    end

    create unique_index(:regions, [:name])
  end
end
