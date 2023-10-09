defmodule CarDealership.CarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarDealership.Cars` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        year: 42,
        color: "some color",
        engine: "some engine",
        model: "some model",
        price: "some price",
        car_photo: "some car_photo",
        car_photo1: "some car_photo1",
        car_photo2: "some car_photo2",
        transmission: "some transmission",
        miles: "some miles",
        vin_no: "some vin_no",
        fuel_type: "some fuel_type",
        is_featured: true
      })
      |> CarDealership.Cars.create_car()

    car
  end
end
