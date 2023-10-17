defmodule CarDealership.Models.Model do
  use Ecto.Schema
  import Ecto.Changeset

  schema "models" do
    field :description, :string
    field :name, :string
    field :year, :integer
    field :color, :string
    field :engine, :string
    field :price, :integer
    field :car_photo, :string
    field :transmission, :string
    field :body_type, :string
    field :miles, :string
    field :vin_no, :string
    field :fuel_type, :string
    field :is_featured, :boolean, default: false

    belongs_to :category, CarDealership.Categories.Category
    has_many :quotes, CarDealership.Quotes.Quote

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [
      :name,
      :category_id,
      :year,
      :color,
      :engine,
      :price,
      :description,
      :car_photo,
      :transmission,
      :miles,
      :body_type,
      :vin_no,
      :fuel_type,
      :is_featured
    ])
    |> validate_required([
      :name,
      :color,
      :year,
      :price,
      :description,
      :car_photo,
      :engine,
      :transmission,
      :miles,
      :vin_no,
      :fuel_type,
      :is_featured,
      :body_type,
      :category_id
    ])
    |> unique_constraint(:vin_no)
  end
end
