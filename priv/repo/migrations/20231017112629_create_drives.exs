defmodule CarDealership.Repo.Migrations.CreateDrives do
  use Ecto.Migration

  def change do
    create table(:drives) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone_number, :string

      add :model_id, references(:models, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
