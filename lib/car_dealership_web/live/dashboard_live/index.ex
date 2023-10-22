defmodule CarDealershipWeb.DashboardLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  use CarDealershipWeb, :live_view
  alias CarDealership.Drives
  alias CarDealership.Models
  alias CarDealership.Quotes

  def mount(params, _session, socket) do
    IO.inspect(params)
    test_drive = Drives.paginate_drives(params).entries
    total_test_drive_pages = Drives.paginate_drives(params).total_pages
    total_test_drive_entries = Drives.paginate_drives(params).total_entries
    total_test_drive_page_number = Drives.paginate_drives(params).page_number

    total_cars = Models.list_models() |> Enum.count()
    categories = Categories.list_categories()
    total_test_drives = Drives.list_drives() |> Enum.count()
    total_quotes_requested = Quotes.list_quotes() |> Enum.count()
    total_quotes = Quotes.list_quotes()
    # IO.inspect(total_cars)
    # IO.inspect(test_drive)
    # IO.inspect(categories)
    IO.inspect(Drives.paginate_drives(params))

    {:ok,
     socket
     |> assign(:test_drive, test_drive)
     |> assign(:total_cars, total_cars)
     |> assign(:categories, categories)
     |> assign(:total_test_drives, total_test_drives)
     |> assign(:total_quotes_requested, total_quotes_requested)
     |> assign(:total_quotes, total_quotes)
     |> assign(:total_test_drive_pages, total_test_drive_pages)
     |> assign(:total_test_drive_entries, total_test_drive_entries)
     |> assign(:total_test_drive_page_number, total_test_drive_page_number)
    }
  end

   defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quotes")
    |> assign(:quote, nil)
  end

  def handle_event("send_sms", params, socket) do
    IO.inspect(params)
    # ticket = Tickets.get_ticket!(params["id"])
    test_drive = Drives.get_drive!(params["id"])
    IO.inspect(test_drive)


    sms_url = "https://api.tiaraconnect.io/api/messaging/sendsms"
    sms_headers = [
      {
        "Content-Type",
        "application/json"
      },
      {
        "Authorization",
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzMDciLCJvaWQiOjMwNywidWlkIjoiY2VkZTU3ZWItMWI1NS00MTQ0LWI5MzEtMzU2Y2MwNDVkN2UzIiwiYXBpZCI6MTk2LCJpYXQiOjE2OTc1NDg4MDcsImV4cCI6MjAzNzU0ODgwN30.GF7Hw_fvQryzd1NdPpHsCz9zh_8ykVdzHRTLrm5rceeOX4u6QKhxtiCgGsxtiH1qdr6-Q0U3Eh-2ySrvTfv9qw"
      }
    ]

    sms_body =
      %{
        "from" => "TIARACONECT",
        "to" => test_drive.phone_number,
        "message" =>
          "Your booking has been confirmed.",
        "refId" => "09wiwu088e"
      }
      |> Poison.encode!()

    IO.inspect(HTTPoison.post(sms_url, sms_body, sms_headers))

    {:noreply,
     socket
     |> put_flash(:info, "SMS sent successfully")}
  end



  @spec handle_event(<<_::64>>, any(), any()) :: {:noreply, any()}
  def handle_event("validate", _params, socket) do
    {:noreply,
     socket
     |> assign(:error_modal, false)}
  end

   def handle_params(params, _url, socket) do
    test_drive = Drives.paginate_drives(params).entries
    total_test_drive_pages = Drives.paginate_drives(params).total_pages
    total_test_drive_entries = Drives.paginate_drives(params).total_entries
    total_test_drive_page_number = Drives.paginate_drives(params).page_number
    {:noreply, socket
      |> assign(:test_drive, test_drive)
      |> assign(:total_test_drive_pages, total_test_drive_pages)
      |> assign(:total_test_drive_entries, total_test_drive_entries)
      |> assign(:total_test_drive_page_number, total_test_drive_page_number)
      |> apply_action(socket.assigns.live_action, params)}
  end
end
