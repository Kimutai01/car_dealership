defmodule CarDealershipWeb.QuoteLive.FormComponent do
  use CarDealershipWeb, :live_component

  alias CarDealership.Quotes

  @impl true
  def update(%{quote: quote} = assigns, socket) do
    changeset = Quotes.change_quote(quote)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"quote" => quote_params}, socket) do
    changeset =
      socket.assigns.quote
      |> Quotes.change_quote(quote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"quote" => quote_params}, socket) do
    save_quote(socket, socket.assigns.action, quote_params)
  end

  defp save_quote(socket, :edit, quote_params) do
    case Quotes.update_quote(socket.assigns.quote, quote_params) do
      {:ok, _quote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quote updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_quote(socket, :add_quote, quote_params) do
    case Quotes.create_quote(quote_params) do
      {:ok, _quote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quote created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
