defmodule CarDealershipWeb.ListingLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  alias CarDealership.Models.Model

  use CarDealershipWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    changeset = Models.change_model(%Model{})

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    models = Models.list_models()

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:categories, categories)
     |> assign(:models, models)}
  end

  def handle_event("validate", params, socket) do
    IO.inspect(params)

    minimum_price =
      if params["model"]["min"] != "" do
        String.to_integer(params["model"]["min"])
      else
        0
      end

    maximum_price =
      if params["model"]["max"] != "" do
        String.to_integer(params["model"]["max"])
      else
        0
      end

    models = Categories.get_category!(String.to_integer(params["model"]["type"])).models
    models = Models.filter_model(minimum_price, maximum_price)

    # Enum.filter(models, fn x -> x.year == year end)
    #  |> IO.inspect()
    # |> Enum.filter(fn x -> x.price >= minimum_price end)
    # |> Enum.filter(fn x -> x.price <= maximum_price end)
    # |> Enum.map(fn x -> {x.name, x.id} end)

    IO.inspect(socket.assigns.changeset)

    {:noreply,
     socket
     |> assign(:models, models)}
  end

  def handle_event("categories", params, socket) do
    IO.inspect(params)

    {:noreply,socket}
  end
end
