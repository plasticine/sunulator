defmodule Sunulator.Repo.Migrations.CreateScenarios do
  use Ecto.Migration

  def change do
    create table(:scenarios) do
      add :name, :string
      add :location_id, references(:locations, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:scenarios, [:location_id])
  end
end