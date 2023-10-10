defmodule CarDealershipWeb.ModelLiveTest do
  use CarDealershipWeb.ConnCase

  import Phoenix.LiveViewTest
  import CarDealership.ModelsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_model(_) do
    model = model_fixture()
    %{model: model}
  end

  describe "Index" do
    setup [:create_model]

    test "lists all models", %{conn: conn, model: model} do
      {:ok, _index_live, html} = live(conn, Routes.model_index_path(conn, :index))

      assert html =~ "Listing Models"
      assert html =~ model.name
    end

    test "saves new model", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.model_index_path(conn, :index))

      assert index_live |> element("a", "New Model") |> render_click() =~
               "New Model"

      assert_patch(index_live, Routes.model_index_path(conn, :new))

      assert index_live
             |> form("#model-form", model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#model-form", model: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.model_index_path(conn, :index))

      assert html =~ "Model created successfully"
      assert html =~ "some name"
    end

    test "updates model in listing", %{conn: conn, model: model} do
      {:ok, index_live, _html} = live(conn, Routes.model_index_path(conn, :index))

      assert index_live |> element("#model-#{model.id} a", "Edit") |> render_click() =~
               "Edit Model"

      assert_patch(index_live, Routes.model_index_path(conn, :edit, model))

      assert index_live
             |> form("#model-form", model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#model-form", model: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.model_index_path(conn, :index))

      assert html =~ "Model updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes model in listing", %{conn: conn, model: model} do
      {:ok, index_live, _html} = live(conn, Routes.model_index_path(conn, :index))

      assert index_live |> element("#model-#{model.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#model-#{model.id}")
    end
  end

  describe "Show" do
    setup [:create_model]

    test "displays model", %{conn: conn, model: model} do
      {:ok, _show_live, html} = live(conn, Routes.model_show_path(conn, :show, model))

      assert html =~ "Show Model"
      assert html =~ model.name
    end

    test "updates model within modal", %{conn: conn, model: model} do
      {:ok, show_live, _html} = live(conn, Routes.model_show_path(conn, :show, model))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Model"

      assert_patch(show_live, Routes.model_show_path(conn, :edit, model))

      assert show_live
             |> form("#model-form", model: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#model-form", model: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.model_show_path(conn, :show, model))

      assert html =~ "Model updated successfully"
      assert html =~ "some updated name"
    end
  end
end
