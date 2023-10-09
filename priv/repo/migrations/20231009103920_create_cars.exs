defmodule CarDealership.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :title, :string, null: false
      add :color, :string, null: false
      add :model, :string, null: false
      add :year, :integer, null: false
      add :price, :string, null: false
      add :description, :string,  null: false
      add :car_photo, :string
      add :car_photo1, :string
      add :car_photo2, :string
      add :engine, :string, null: false
      add :transmission, :string, null: false
      add :miles, :string, null: false
      add :vin_no, :string, null: false
      add :fuel_type, :string, null: false
      add :is_featured, :boolean, default: false, null: false
      add :category_id, references(:categories, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:cars, [:vin_no])

  end
end
