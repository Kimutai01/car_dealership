defmodule CarDealershipWeb.DriveLive.Index do
  use CarDealershipWeb, :live_view

  alias CarDealership.Drives
  alias CarDealership.Drives.Drive

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :drives, list_drives())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Drive")
    |> assign(:drive, Drives.get_drive!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Drive")
    |> assign(:drive, %Drive{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Drives")
    |> assign(:drive, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    drive = Drives.get_drive!(id)
    {:ok, _} = Drives.delete_drive(drive)

    {:noreply, assign(socket, :drives, list_drives())}
  end

  defp list_drives do
    Drives.list_drives()
  end
end
