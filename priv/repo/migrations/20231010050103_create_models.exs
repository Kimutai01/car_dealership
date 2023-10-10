defmodule CarDealership.Repo.Migrations.CreateModels do
  use Ecto.Migration

  def change do
    create table(:models) do
      add :name, :string

      add :category_id, references(:categories, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
