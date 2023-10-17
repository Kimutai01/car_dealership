defmodule CarDealershipWeb.ModelLive.Show do
  use CarDealershipWeb, :live_view
  alias CarDealership.Quotes.Quote
  alias CarDealership.Drives.Drive
  alias CarDealership.Drives
  alias CarDealership.Mpesas
  alias CarDealership.Models

  @impl true
  def mount(params, _session, socket) do
    IO.inspect(params)
    model = Models.get_model!(params["id"])

    {:ok,
     socket
     |> assign(:return_to, Routes.model_show_path(CarDealershipWeb.Endpoint, :show, model))
     |> assign(:error_modal, false)
     |> assign(:n, false)
     |> assign(:success_modal, false)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    IO.inspect(id)
    model = Models.get_model!(id)
    IO.inspect(model.body_type)

    models =
      Models.get_models_by_body_type(model.body_type)
      |> Enum.reject(fn x -> x.id == String.to_integer(id) end)

    IO.inspect(models)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:model, model)
     |> assign(:models, models)
     |> assign(:quote, %Quote{})
     |> assign(:drive, %Drive{})}
  end

  def handle_event("validate", %{"_target" => _, "drive" => drive_params}, socket) do
    changeset =
      socket.assigns.drive
      |> Drives.change_drive(drive_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"drive" => drive_params}, socket) do
    case Mpesas.make_request(
           1,
           drive_params["phone_number"],
           "reference",
           "description"
         ) do
      {:error, %HTTPoison.Error{reason: :timeout, id: nil}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Session timed out")}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:info, "An error occured #{error}")}

      {:ok, mpesa} ->
        {:noreply,
         socket
         |> assign(:checkoutId, mpesa["CheckoutRequestID"])
         |> assign(:first_name, drive_params["first_name"])
         |> assign(:last_name, drive_params["last_name"])
         |> assign(:phone_number, drive_params["phone_number"])
         |> assign(:email, drive_params["email"])
         |> assign(:model_id, drive_params["model_id"])
         |> factorial(socket.assigns.n, "Initiated", drive_params)}

      _ ->
        {:noreply, socket}
    end
  end

  def factorial(socket, n, string, id) when n == false do
    case IO.inspect(Mpesas.make_query(socket.assigns.checkoutId)) do
      {:ok, mpesa} ->
        case mpesa["ResultCode"] do
          "0" ->
            factorial(socket, true, "Paid", id)

          "1" ->
            socket
            |> factorial("error", "Balance is insufficient", id)

          "17" ->
            socket
            |> factorial("error", "Check if you entered details correctly", id)

          "26" ->
            socket
            |> factorial("error", "System busy, Try again in a short while", id)

          "2001" ->
            socket
            |> factorial("error", "Wrong Pin entered", id)

          "1001" ->
            socket
            |> factorial("error", "Unable to lock subscriber", id)

          "1019" ->
            socket
            |> factorial("error", "Transaction expired. No MO has been received", id)

          "9999" ->
            socket
            |> factorial("error", "Request cancelled by user", id)

          "1032" ->
            factorial(socket, "error", "Request cancelled by user", id)

          "1036" ->
            socket
            |> factorial("error", "SMSC ACK timeout", id)

          "1037" ->
            socket
            |> factorial("error", "Payment timeout", id)

          "SFC_IC0003" ->
            socket
            |> factorial("error", "Payment timeout", id)

          _ ->
            socket
            |> put_flash("error", "Error processing payment ")
        end

      {:error, params} ->
        IO.inspect("i am here")

        factorial(socket, false, "Payment has started", id)
    end
  end

  def factorial(socket, n, string, id) when n == true do
    new_params = %{
      "first_name" => socket.assigns.first_name,
      "last_name" => socket.assigns.last_name,
      "phone_number" => socket.assigns.phone_number,
      "email" => socket.assigns.email,
      "model_id" => socket.assigns.model_id
    }

    case IO.inspect(Drives.create_drive(new_params)) do
      {:ok, _drive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Drive created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end

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
        "to" => socket.assigns.phone_number,
        "message" =>
          "Thank you for booking a test drive with us. We will get back to you shortly.",
        "refId" => "09wiwu088e"
      }
      |> Poison.encode!()

    IO.inspect(HTTPoison.post(sms_url, sms_body, sms_headers))

    socket
    |> assign(:success_modal, true)
    |> put_flash(:info, "Succesfully Paid")
  end

  def factorial(socket, n, string, id) when n == "error" do
    socket
    |> assign(:error_message, string)
    |> assign(:error_modal, true)
    |> put_flash(:info, string)
  end

  def handle_event("close_success_modal", %{}, socket) do
    {:noreply,
     socket
     |> assign(:success_modal, false)}
  end

  def handle_event("close_error_modal", %{}, socket) do
    {:noreply,
     socket
     |> assign(:error_modal, false)}
  end

  defp page_title(:show), do: "Show Model"
  defp page_title(:edit), do: "Edit Model"
  defp page_title(:add_cars), do: "Add Cars"
  defp page_title(:add_quote), do: "Add Quote"
  defp page_title(:book_test_drive), do: "Book Test Drive"
end
