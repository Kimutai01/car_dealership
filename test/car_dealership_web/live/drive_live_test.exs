defmodule CarDealershipWeb.DriveLiveTest do
  use CarDealershipWeb.ConnCase

  import Phoenix.LiveViewTest
  import CarDealership.DrivesFixtures

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    email: "some email",
    phone_number: "some phone_number"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    email: "some updated email",
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, email: nil, phone_number: nil}

  defp create_drive(_) do
    drive = drive_fixture()
    %{drive: drive}
  end

  describe "Index" do
    setup [:create_drive]

    test "lists all drives", %{conn: conn, drive: drive} do
      {:ok, _index_live, html} = live(conn, Routes.drive_index_path(conn, :index))

      assert html =~ "Listing Drives"
      assert html =~ drive.first_name
    end

    test "saves new drive", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.drive_index_path(conn, :index))

      assert index_live |> element("a", "New Drive") |> render_click() =~
               "New Drive"

      assert_patch(index_live, Routes.drive_index_path(conn, :new))

      assert index_live
             |> form("#drive-form", drive: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#drive-form", drive: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drive_index_path(conn, :index))

      assert html =~ "Drive created successfully"
      assert html =~ "some first_name"
    end

    test "updates drive in listing", %{conn: conn, drive: drive} do
      {:ok, index_live, _html} = live(conn, Routes.drive_index_path(conn, :index))

      assert index_live |> element("#drive-#{drive.id} a", "Edit") |> render_click() =~
               "Edit Drive"

      assert_patch(index_live, Routes.drive_index_path(conn, :edit, drive))

      assert index_live
             |> form("#drive-form", drive: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#drive-form", drive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drive_index_path(conn, :index))

      assert html =~ "Drive updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes drive in listing", %{conn: conn, drive: drive} do
      {:ok, index_live, _html} = live(conn, Routes.drive_index_path(conn, :index))

      assert index_live |> element("#drive-#{drive.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#drive-#{drive.id}")
    end
  end

  describe "Show" do
    setup [:create_drive]

    test "displays drive", %{conn: conn, drive: drive} do
      {:ok, _show_live, html} = live(conn, Routes.drive_show_path(conn, :show, drive))

      assert html =~ "Show Drive"
      assert html =~ drive.first_name
    end

    test "updates drive within modal", %{conn: conn, drive: drive} do
      {:ok, show_live, _html} = live(conn, Routes.drive_show_path(conn, :show, drive))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Drive"

      assert_patch(show_live, Routes.drive_show_path(conn, :edit, drive))

      assert show_live
             |> form("#drive-form", drive: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#drive-form", drive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drive_show_path(conn, :show, drive))

      assert html =~ "Drive updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
