defmodule Sunulator.Repo.Migrations.CreateSamples do
  use Ecto.Migration

  def change do
    Sunulator.Locations.Sample.IntervalEnum.create_type()

    create table(:samples) do
      add :day, :integer
      add :interval, :integer
      add :interval_type, Sunulator.Locations.Sample.IntervalEnum.type()
      add :beam, :float
      add :diffuse, :float
      add :bulb_temp, :float
      add :location_id, references(:locations, on_delete: :delete_all), null: false
    end

    create index(:samples, [:location_id])
  end
end
