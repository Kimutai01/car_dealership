defmodule CarDealership.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string, null: false
      add :color, :string, null: false
      add :year, :integer, null: false
      add :price, :integer, null: false
      add :description, :string, null: false
      add :car_photo, :string, null: false
      add :engine, :string, null: false
      add :transmission, :string, null: false
      add :miles, :string, null: false
      add :vin_no, :string, null: false
      add :fuel_type, :string, null: false
      add :is_featured, :boolean, default: false, null: false

      add :category_id, references(:categories, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
