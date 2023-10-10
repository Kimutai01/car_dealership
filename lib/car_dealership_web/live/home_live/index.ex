defmodule CarDealershipWeb.HomeLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Cars
  alias CarDealership.Cars.Car
  use CarDealershipWeb, :live_view

  def handle_event("validate", params, socket) do
    category = Categories.list_categories()
    {:noreply,socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    changeset = Cars.change_car(%Car{})
    categories = Categories.list_categories()
    mapped_categories = Enum.map(categories, fn x -> x.name end)
    IO.inspect changeset
    {:ok, socket
    |> assign(:cars, Cars.list_cars())
    |> assign(:changeset, changeset)
    |> assign(:mapped_categories, mapped_categories)}
  end


end
