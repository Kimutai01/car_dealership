defmodule CarDealershipWeb.ListingLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  alias CarDealership.Models.Model
  alias CarDealership.Accounts

  use CarDealershipWeb, :live_view
  @impl true
  def mount(params, session, socket) do
    changeset = Models.change_model(%Model{})

    user_signed_in =
      if is_nil(session["user_token"]) do
        false
      else
        true
      end

    current_user =
      if user_signed_in do
        Accounts.get_user_by_session_token(session["user_token"])
      end

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    models = Models.paginate_models(params).entries
    total_pages = Models.paginate_models(params).total_pages
    page_number = Models.paginate_models(params).page_number
    total_entries = Models.paginate_models(params).total_entries
    IO.inspect(models)

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:categories, categories)
     |> assign(:max_value, "")
     |> assign(:min_value, "")
     |> assign(:category, "")
     |> assign(:models, models)
     |> assign(:user_signed_in, user_signed_in)
     |> assign(:total_pages, total_pages)
     |> assign(:page_number, page_number)
     |> assign(:total_entries, total_entries)
     |> assign(:current_user, current_user)}
  end

  def handle_event("validate", params, socket) do
    {:noreply,
     socket
     |> assign(:max_value, params["model"]["max"])
     |> assign(:category, params["model"]["type"])
     |> assign(:min_value, params["model"]["min"])}
  end

  def handle_event("save", _, socket) do
    minimum_price =
      if socket.assigns.min_value != "" do
        String.to_integer(socket.assigns.min_value)
      else
        0
      end

    maximum_price =
      if socket.assigns.max_value != "" do
        String.to_integer(socket.assigns.max_value)
      else
        0
      end

    models =
      Models.filter_model(
        String.to_integer(socket.assigns.category),
        minimum_price,
        maximum_price
      )

    IO.inspect(models)

    {:noreply,
     socket
     |> assign(:models, models)}
  end

  def handle_event("categories", params, socket) do
    IO.inspect(params)

    models =
      if params["name"] != "all" do
        Models.get_models_by_body_type(params["name"])
      else
        Models.list_models()
      end

    {:noreply, socket |> assign(:models, models)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quotes")
    |> assign(:quote, nil)
  end

  def handle_params(params, _url, socket) do
    models = Models.paginate_models(params).entries
    total_pages = Models.paginate_models(params).total_pages
    page_number = Models.paginate_models(params).page_number
    total_entries = Models.paginate_models(params).total_entries

    {:noreply,
     socket
     |> assign(:models, models)
     |> assign(:total_pages, total_pages)
     |> assign(:page_number, page_number)
     |> assign(:total_entries, total_entries)
     |> apply_action(socket.assigns.live_action, params)}
  end
end
