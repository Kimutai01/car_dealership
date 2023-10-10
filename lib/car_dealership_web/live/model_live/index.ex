defmodule CarDealershipWeb.ModelLive.Index do
  use CarDealershipWeb, :live_view

  alias CarDealership.Models
  alias CarDealership.Models.Model

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :models, list_models())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Model")
    |> assign(:model, Models.get_model!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Model")
    |> assign(:model, %Model{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Models")
    |> assign(:model, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    model = Models.get_model!(id)
    {:ok, _} = Models.delete_model(model)

    {:noreply, assign(socket, :models, list_models())}
  end

  defp list_models do
    Models.list_models()
  end
end
