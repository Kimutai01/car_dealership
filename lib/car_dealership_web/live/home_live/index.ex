defmodule CarDealershipWeb.HomeLive.Index do
  alias CarDealership.Categories

  use CarDealershipWeb, :live_view

  def handle_event("validate", params, socket) do
    IO.inspect(params)

    models =
      Categories.get_category!(String.to_integer(params["car"]["type"])).models
      |> Enum.map(fn x -> {x.name, x.id} end)

    # cars =
    #   if params["car"]["brand"] != nil do
    #     Models.get_model!(String.to_integer(params["car"]["brand"])).cars
    #   else
    #     []
    #   end

    # # cars = Models.get_model!(String.to_integer(params["car"]["brand"])).cars
    # IO.inspect(cars)

    # year = if params["car"]["year"] != nil do
    #   params["car"]["year"]
    # else
    #   ""
    # end

    # minimum_price = if params["car"]["min"] != nil do
    #   params["car"]["minimum_price"]
    # else
    #   ""
    # end

    # maximum_price = if params["car"]["maximum_price"] != nil do
    #   params["car"]["maximum_price"]
    # else
    #   ""
    # end

    # Enum.filter(cars, fn x -> x.year == year end)
    # |> Enum.filter(fn x -> x.price >= minimum_price end)
    # |> Enum.filter(fn x -> x.price <= maximum_price end)
    # |> Enum.map(fn x -> {x.name, x.id} end)

    {:noreply,
     socket
     |> assign(:models, models)}
  end

  @impl true
  def mount(_params, _session, socket) do
    # changeset = Cars.change_car(%Car{})

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    {:ok,
     socket
    #  |> assign(:changeset, changeset)
     |> assign(:categories, categories)
     |> assign(:models, [])}
  end
end
