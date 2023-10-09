defmodule CarDealershipWeb.CarLiveTest do
  use CarDealershipWeb.ConnCase

  import Phoenix.LiveViewTest
  import CarDealership.CarsFixtures

  @create_attrs %{description: "some description", title: "some title", year: 42, color: "some color", engine: "some engine", model: "some model", price: "some price", car_photo: "some car_photo", car_photo1: "some car_photo1", car_photo2: "some car_photo2", transmission: "some transmission", miles: "some miles", vin_no: "some vin_no", fuel_type: "some fuel_type", is_featured: true}
  @update_attrs %{description: "some updated description", title: "some updated title", year: 43, color: "some updated color", engine: "some updated engine", model: "some updated model", price: "some updated price", car_photo: "some updated car_photo", car_photo1: "some updated car_photo1", car_photo2: "some updated car_photo2", transmission: "some updated transmission", miles: "some updated miles", vin_no: "some updated vin_no", fuel_type: "some updated fuel_type", is_featured: false}
  @invalid_attrs %{description: nil, title: nil, year: nil, color: nil, engine: nil, model: nil, price: nil, car_photo: nil, car_photo1: nil, car_photo2: nil, transmission: nil, miles: nil, vin_no: nil, fuel_type: nil, is_featured: false}

  defp create_car(_) do
    car = car_fixture()
    %{car: car}
  end

  describe "Index" do
    setup [:create_car]

    test "lists all cars", %{conn: conn, car: car} do
      {:ok, _index_live, html} = live(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Listing Cars"
      assert html =~ car.description
    end

    test "saves new car", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("a", "New Car") |> render_click() =~
               "New Car"

      assert_patch(index_live, Routes.car_index_path(conn, :new))

      assert index_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#car-form", car: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Car created successfully"
      assert html =~ "some description"
    end

    test "updates car in listing", %{conn: conn, car: car} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("#car-#{car.id} a", "Edit") |> render_click() =~
               "Edit Car"

      assert_patch(index_live, Routes.car_index_path(conn, :edit, car))

      assert index_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#car-form", car: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Car updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes car in listing", %{conn: conn, car: car} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("#car-#{car.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#car-#{car.id}")
    end
  end

  describe "Show" do
    setup [:create_car]

    test "displays car", %{conn: conn, car: car} do
      {:ok, _show_live, html} = live(conn, Routes.car_show_path(conn, :show, car))

      assert html =~ "Show Car"
      assert html =~ car.description
    end

    test "updates car within modal", %{conn: conn, car: car} do
      {:ok, show_live, _html} = live(conn, Routes.car_show_path(conn, :show, car))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Car"

      assert_patch(show_live, Routes.car_show_path(conn, :edit, car))

      assert show_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#car-form", car: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_show_path(conn, :show, car))

      assert html =~ "Car updated successfully"
      assert html =~ "some updated description"
    end
  end
end
