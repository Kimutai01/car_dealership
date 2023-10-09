defmodule CarDealership.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :logo, :string

      timestamps()
    end
  end
end
