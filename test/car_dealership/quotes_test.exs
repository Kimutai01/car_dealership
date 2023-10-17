defmodule CarDealership.QuotesTest do
  use CarDealership.DataCase

  alias CarDealership.Quotes

  describe "quotes" do
    alias CarDealership.Quotes.Quote

    import CarDealership.QuotesFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, email: nil, phone_number: nil}

    test "list_quotes/0 returns all quotes" do
      quote = quote_fixture()
      assert Quotes.list_quotes() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Quotes.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      valid_attrs = %{
        first_name: "some first_name",
        last_name: "some last_name",
        email: "some email",
        phone_number: "some phone_number"
      }

      assert {:ok, %Quote{} = quote} = Quotes.create_quote(valid_attrs)
      assert quote.first_name == "some first_name"
      assert quote.last_name == "some last_name"
      assert quote.email == "some email"
      assert quote.phone_number == "some phone_number"
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotes.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()

      update_attrs = %{
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        email: "some updated email",
        phone_number: "some updated phone_number"
      }

      assert {:ok, %Quote{} = quote} = Quotes.update_quote(quote, update_attrs)
      assert quote.first_name == "some updated first_name"
      assert quote.last_name == "some updated last_name"
      assert quote.email == "some updated email"
      assert quote.phone_number == "some updated phone_number"
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Quotes.update_quote(quote, @invalid_attrs)
      assert quote == Quotes.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Quotes.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Quotes.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Quotes.change_quote(quote)
    end
  end
end
