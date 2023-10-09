defmodule CarDealership.CarsTest do
  use CarDealership.DataCase

  alias CarDealership.Cars

  describe "cars" do
    alias CarDealership.Cars.Car

    import CarDealership.CarsFixtures

    @invalid_attrs %{description: nil, title: nil, year: nil, color: nil, engine: nil, model: nil, price: nil, car_photo: nil, car_photo1: nil, car_photo2: nil, transmission: nil, miles: nil, vin_no: nil, fuel_type: nil, is_featured: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Cars.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{description: "some description", title: "some title", year: 42, color: "some color", engine: "some engine", model: "some model", price: "some price", car_photo: "some car_photo", car_photo1: "some car_photo1", car_photo2: "some car_photo2", transmission: "some transmission", miles: "some miles", vin_no: "some vin_no", fuel_type: "some fuel_type", is_featured: true}

      assert {:ok, %Car{} = car} = Cars.create_car(valid_attrs)
      assert car.description == "some description"
      assert car.title == "some title"
      assert car.year == 42
      assert car.color == "some color"
      assert car.engine == "some engine"
      assert car.model == "some model"
      assert car.price == "some price"
      assert car.car_photo == "some car_photo"
      assert car.car_photo1 == "some car_photo1"
      assert car.car_photo2 == "some car_photo2"
      assert car.transmission == "some transmission"
      assert car.miles == "some miles"
      assert car.vin_no == "some vin_no"
      assert car.fuel_type == "some fuel_type"
      assert car.is_featured == true
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", year: 43, color: "some updated color", engine: "some updated engine", model: "some updated model", price: "some updated price", car_photo: "some updated car_photo", car_photo1: "some updated car_photo1", car_photo2: "some updated car_photo2", transmission: "some updated transmission", miles: "some updated miles", vin_no: "some updated vin_no", fuel_type: "some updated fuel_type", is_featured: false}

      assert {:ok, %Car{} = car} = Cars.update_car(car, update_attrs)
      assert car.description == "some updated description"
      assert car.title == "some updated title"
      assert car.year == 43
      assert car.color == "some updated color"
      assert car.engine == "some updated engine"
      assert car.model == "some updated model"
      assert car.price == "some updated price"
      assert car.car_photo == "some updated car_photo"
      assert car.car_photo1 == "some updated car_photo1"
      assert car.car_photo2 == "some updated car_photo2"
      assert car.transmission == "some updated transmission"
      assert car.miles == "some updated miles"
      assert car.vin_no == "some updated vin_no"
      assert car.fuel_type == "some updated fuel_type"
      assert car.is_featured == false
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Cars.update_car(car, @invalid_attrs)
      assert car == Cars.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Cars.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Cars.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Cars.change_car(car)
    end
  end
end
