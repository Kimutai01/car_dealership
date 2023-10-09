defmodule CarDealership.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :description, :string
    field :title, :string
    field :year, :integer
    field :color, :string
    field :engine, :string
    field :model, :string
    field :price, :string
    field :car_photo, :string
    field :car_photo1, :string
    field :car_photo2, :string
    field :transmission, :string
    field :miles, :string
    field :vin_no, :string
    field :fuel_type, :string
    field :is_featured, :boolean, default: false

    belongs_to :category, CarDealership.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:title, :color, :model, :year, :price, :description, :car_photo, :car_photo1, :car_photo2, :engine, :transmission, :miles, :vin_no, :fuel_type, :is_featured, :category_id])
    |> validate_required([:title, :color, :model, :year, :price, :description, :car_photo, :car_photo1, :car_photo2, :engine, :transmission, :miles, :vin_no, :fuel_type, :is_featured, :category_id])
    |> unique_constraint(:vin_no)
  end
end
