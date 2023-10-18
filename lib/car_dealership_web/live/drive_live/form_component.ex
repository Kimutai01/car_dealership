defmodule CarDealershipWeb.DriveLive.FormComponent do
  use CarDealershipWeb, :live_component
  alias CarDealership.Drives

  @impl true
  def update(%{drive: drive} = assigns, socket) do
    changeset = Drives.change_drive(drive)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"drive" => drive_params}, socket) do
    changeset =
      socket.assigns.drive
      |> Drives.change_drive(drive_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"drive" => drive_params}, socket) do
    save_drive(socket, socket.assigns.action, drive_params)
  end

  defp save_drive(socket, :edit, drive_params) do
    case Drives.update_drive(socket.assigns.drive, drive_params) do
      {:ok, _drive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Drive updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # defp save_drive(socket, :book_test_drive, drive_params) do

  # case Drives.create_drive(drive_params) do
  #   {:ok, _drive} ->
  #     {:noreply,
  #      socket
  #      |> put_flash(:info, "Drive created successfully")
  #      |> push_redirect(to: socket.assigns.return_to)}

  #   {:error, %Ecto.Changeset{} = changeset} ->
  #     {:noreply, assign(socket, changeset: changeset)}
  # end
  # end
end
