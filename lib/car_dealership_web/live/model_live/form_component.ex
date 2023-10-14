defmodule CarDealershipWeb.ModelLive.FormComponent do
  use CarDealershipWeb, :live_component

  alias CarDealership.Models

  @impl true
  def update(%{model: model} = assigns, socket) do
    changeset = Models.change_model(model)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)}
  end

  @impl true
  def handle_event("validate", %{"model" => model_params}, socket) do
    changeset =
      socket.assigns.model
      |> Models.change_model(model_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"model" => model_params}, socket) do
    IO.inspect(model_params)

    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest =
          Path.join([:code.priv_dir(:car_dealership), "static", "uploads", Path.basename(path)])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    new_model_params = Map.put(model_params, "car_photo", List.first(uploaded_files))
    IO.inspect(new_model_params)

    save_model(socket, socket.assigns.action, new_model_params)
  end

  defp save_model(socket, :edit, model_params) do
    case Models.update_model(socket.assigns.model, model_params) do
      {:ok, _model} ->
        {:noreply,
         socket
         |> put_flash(:info, "Model updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  defp save_model(socket, :add_models, model_params) do
    case Models.create_model(model_params) do
      {:ok, _model} ->
        {:noreply,
         socket
         |> put_flash(:info, "Model created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
