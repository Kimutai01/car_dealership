defmodule CarDealershipWeb.ListingLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  alias CarDealership.Models.Model

  use CarDealershipWeb, :live_view
  @impl true
  def mount(_params, _session, socket) do
    changeset = Models.change_model(%Model{})

    categories =
      Categories.list_categories()
      |> Enum.map(fn x -> {x.name, x.id} end)

    models = Models.list_models()
    IO.inspect(models)

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:categories, categories)
     |> assign(:max_value , "")
      |> assign(:min_value , "")
      |> assign(:category , "")
     |> assign(:models, models)}
  end

  def handle_event("validate", params, socket) do


    {:noreply,
     socket
     |> assign(:max_value , params["model"]["max"])
     |> assign(:category , params["model"]["type"])
     |> assign(:min_value , params["model"]["min"])
    }
  end

  def handle_event("save", _ , socket) do

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






    models = Models.filter_model(String.to_integer(socket.assigns.category),minimum_price, maximum_price)


    IO.inspect(models)

     {:noreply,
     socket

     |> assign(:models, models)}

  end

  def handle_event("categories", params, socket) do
    IO.inspect(params)


    models = if params["name"] != "all" do
      Models.get_models_by_body_type(params["name"])
    else
      Models.list_models()
    end



    {:noreply, socket |> assign(:models, models)}
  end
end
