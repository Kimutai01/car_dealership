defmodule CarDealership.Models.Model do
  use Ecto.Schema
  import Ecto.Changeset

  schema "models" do
    field :name, :string

    belongs_to :category, CarDealership.Categories.Category
    has_many :cars, CarDealership.Cars.Car

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :category_id])
    |> validate_required([:name, :category_id])
  end
end
