defmodule CarDealershipWeb.DashboardLive.Index do
  alias CarDealership.Categories
  alias CarDealership.Models
  use CarDealershipWeb, :dashboard_live_view
  alias CarDealership.Drives
  alias CarDealership.Models
  alias CarDealership.Quotes
  alias CarDealership.Accounts

  def mount(params, session, socket) do
    IO.inspect(params)

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

    test_drive = Drives.paginate_drives(params).entries
    total_test_drive_pages = Drives.paginate_drives(params).total_pages
    total_test_drive_entries = Drives.paginate_drives(params).total_entries
    total_test_drive_page_number = Drives.paginate_drives(params).page_number
    categories = Categories.list_categories()
    IO.inspect(categories)
    cars = Models.list_models()

    total_cars = Models.list_models() |> Enum.count()
    categories = Categories.list_categories()
    total_test_drives = Drives.list_drives() |> Enum.count()
    total_quotes_requested = Quotes.list_quotes() |> Enum.count()
    quotes = Quotes.paginate_quotes(params).entries
    total_quotes = Quotes.paginate_quotes(params).total_entries
    total_quote_pages = Quotes.paginate_quotes(params).total_pages
    total_quote_page_number = Quotes.paginate_quotes(params).page_number

    # IO.inspect(total_cars)
    # IO.inspect(test_drive)
    # IO.inspect(categories)

    {:ok,
     socket
     |> assign(:url, "/dashboard")
     |> assign(:test_drive, test_drive)
     |> assign(:total_cars, total_cars)
     |> assign(:categories, categories)
     |> assign(:total_test_drives, total_test_drives)
     |> assign(:total_quotes_requested, total_quotes_requested)
     |> assign(:total_quotes, total_quotes)
     |> assign(:quotes, quotes)
     |> assign(:total_test_drive_pages, total_test_drive_pages)
     |> assign(:total_test_drive_entries, total_test_drive_entries)
     |> assign(:total_test_drive_page_number, total_test_drive_page_number)
     |> assign(:total_quote_pages, total_quote_pages)
     |> assign(:total_quote_page_number, total_quote_page_number)
     |> assign(:cars, cars)
     |> assign(:categories, categories)
     |> assign(:user_signed_in, user_signed_in)
     |> assign(:current_user, current_user)
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Quotes")
    |> assign(:quote, nil)
  end

  def handle_event("send_sms", params, socket) do
    IO.inspect(params)

    if params["name"] == "test_drive" do
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
          "message" => "Your booking has been confirmed.",
          "refId" => "09wiwu088e"
        }
        |> Poison.encode!()

      IO.inspect(HTTPoison.post(sms_url, sms_body, sms_headers))

      {:noreply,
       socket
       |> put_flash(:info, "SMS sent successfully")}
    else
      quote = Quotes.get_quote!(params["id"])
      IO.inspect(quote)

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
          "to" => quote.phone_number,
          "message" => "Your quote has been sent on your email.",
          "refId" => "09wiwu088e"
        }
        |> Poison.encode!()

      IO.inspect(HTTPoison.post(sms_url, sms_body, sms_headers))

      {:noreply,
       socket
       |> put_flash(:info, "SMS sent successfully")}
    end

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
    quotes = Quotes.paginate_quotes(params).entries
    total_quotes = Quotes.paginate_quotes(params).total_entries
    total_quote_pages = Quotes.paginate_quotes(params).total_pages
    total_quote_page_number = Quotes.paginate_quotes(params).page_number

    {:noreply,
     socket
     |> assign(:test_drive, test_drive)
     |> assign(:total_test_drive_pages, total_test_drive_pages)
     |> assign(:total_test_drive_entries, total_test_drive_entries)
     |> assign(:total_test_drive_page_number, total_test_drive_page_number)
     |> assign(:quotes, quotes)
     |> assign(:total_quotes, total_quotes)
     |> assign(:total_quote_pages, total_quote_pages)
     |> assign(:total_quote_page_number, total_quote_page_number)
     |> apply_action(socket.assigns.live_action, params)}
  end
end
