defmodule CarDealershipWeb.ModelLive.Show do
  use CarDealershipWeb, :live_view

  alias CarDealership.Models
  alias CarDealership.Cars.Car

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:car, %Car{})}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:model, Models.get_model!(id))}
  end

  defp page_title(:show), do: "Show Model"
  defp page_title(:edit), do: "Edit Model"
  defp page_title(:add_cars), do: "Add Cars"
end
