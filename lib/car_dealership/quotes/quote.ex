defmodule CarDealership.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone_number, :string

    belongs_to :model, CarDealership.Models.Model

    timestamps()
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:first_name, :last_name, :email, :phone_number, :model_id])
    |> validate_required([:first_name, :last_name, :email, :phone_number, :model_id])
  end
end
