defmodule CarDealership.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :phone_number, :string, null: false
      add :model_id, references(:models, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
