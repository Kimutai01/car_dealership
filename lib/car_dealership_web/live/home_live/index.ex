defmodule CarDealershipWeb.HomeLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models

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
  def mount(_params, _session, socket) do
    models = Models.get_featured_cars()

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    {:ok,
     socket
     |> assign(:categories, categories)
     |> assign(:models, models)}
  end
end
