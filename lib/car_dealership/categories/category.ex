defmodule CarDealership.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :logo, :string

    has_many :cars, CarDealership.Cars.Car

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :logo])
    |> validate_required([:name, :logo])
  end
end
