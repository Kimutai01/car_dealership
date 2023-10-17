defmodule CarDealership.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarDealership.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        email: "some email",
        phone_number: "some phone_number"
      })
      |> CarDealership.Quotes.create_quote()

    quote
  end
end
