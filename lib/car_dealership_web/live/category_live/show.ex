defmodule CarDealershipWeb.CategoryLive.Show do
  use CarDealershipWeb, :live_view

  alias CarDealership.Cars.Car

  alias CarDealership.Categories

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:car, %Car{})}
  end

  @impl true
  def handle_params(params, _, socket) do

    IO.inspect params
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:category, Categories.get_category!(params["id"]))}
  end

  defp page_title(:show), do: "Show Category"
  defp page_title(:edit), do: "Edit Category"
  defp page_title(:add_cars), do: "Cars"
end
