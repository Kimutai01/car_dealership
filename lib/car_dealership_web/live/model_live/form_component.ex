defmodule CarDealershipWeb.ModelLive.FormComponent do
  use CarDealershipWeb, :live_component

  alias CarDealership.Models

  @impl true
  def update(%{model: model} = assigns, socket) do
    changeset = Models.change_model(model)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"model" => model_params}, socket) do
    changeset =
      socket.assigns.model
      |> Models.change_model(model_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"model" => model_params}, socket) do
    save_model(socket, socket.assigns.action, model_params)
  end

  defp save_model(socket, :edit, model_params) do
    case Models.update_model(socket.assigns.model, model_params) do
      {:ok, _model} ->
        {:noreply,
         socket
         |> put_flash(:info, "Model updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_model(socket, :add_models, model_params) do
    case Models.create_model(model_params) do
      {:ok, _model} ->
        {:noreply,
         socket
         |> put_flash(:info, "Model created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
