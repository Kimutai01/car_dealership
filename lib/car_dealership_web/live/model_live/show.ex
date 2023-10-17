defmodule CarDealershipWeb.ModelLive.Show do
  use CarDealershipWeb, :live_view

  alias CarDealership.Models

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    IO.inspect(id)
    model = Models.get_model!(id)
    IO.inspect(model.body_type)

    models = Models.get_models_by_body_type(model.body_type) |> Enum.reject(fn x -> x.id == String.to_integer(id) end)
    IO.inspect(models)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:model, model)
     |> assign(:models, models)}
  end

  defp page_title(:show), do: "Show Model"
  defp page_title(:edit), do: "Edit Model"
  defp page_title(:add_cars), do: "Add Cars"
end
