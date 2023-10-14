defmodule CarDealershipWeb.HomeLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  alias CarDealership.Accounts

  use CarDealershipWeb, :live_view

  def handle_event("validate", params, socket) do
    IO.inspect(params)

    {
      :noreply,
      socket
      #  |> assign(:models, models)}
    }
  end

  @impl true
  def mount(_params, session, socket) do
    models = Models.get_featured_cars()

    latest_cars = Models.get_latest_cars()

    user_signed_in =
      if is_nil(session["user_token"]) do
        false
      else
        true
      end

    current_user =
      if user_signed_in do
        Accounts.get_user_by_session_token(session["user_token"])
      end

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    {:ok,
     socket
     |> assign(:categories, categories)
     |> assign(:models, models)
     |> assign(:latest_cars, latest_cars)
     |> assign(:user_signed_in, user_signed_in)
     |> assign(:current_user, current_user)}

  end
end
