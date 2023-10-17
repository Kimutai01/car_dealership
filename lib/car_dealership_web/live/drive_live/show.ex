defmodule CarDealershipWeb.DriveLive.Show do
  use CarDealershipWeb, :live_view

  alias CarDealership.Drives

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:drive, Drives.get_drive!(id))}
  end

  defp page_title(:show), do: "Show Drive"
  defp page_title(:edit), do: "Edit Drive"
end
