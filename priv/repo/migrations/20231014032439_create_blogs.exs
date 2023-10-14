defmodule CarDealership.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :content, :string
      add :tag, :string

      timestamps()
    end
  end
end
