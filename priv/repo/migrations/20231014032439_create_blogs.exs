defmodule CarDealership.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string, null: false
      add :content, :string, null: false
      add :tag, :string, null: false

      timestamps()
    end
  end
end
