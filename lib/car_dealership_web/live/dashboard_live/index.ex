defmodule CarDealershipWeb.DashboardLive.Index do
  use CarDealershipWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end
end
