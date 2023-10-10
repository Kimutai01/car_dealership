defmodule CarDealershipWeb.HomeLive.Index do
  alias CarDealership.Cars
  use CarDealershipWeb, :live_view




  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign(:cars, Cars.list_cars())}
  end


end
