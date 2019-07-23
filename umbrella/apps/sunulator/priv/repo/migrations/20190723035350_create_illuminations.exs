defmodule Sunulator.Repo.Migrations.CreateIlluminations do
  use Ecto.Migration

  def change do
    create table(:illuminations) do
      add :day, :integer
      add :hour, :integer
      add :beam, :float
      add :diffuse, :float
      add :bulb_temp, :float
      add :location_id, references(:locations, on_delete: :delete_all), null: false
    end

    create index(:illuminations, [:location_id])
  end
end
