defmodule CarDealership.ModelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarDealership.Models` context.
  """

  @doc """
  Generate a model.
  """
  def model_fixture(attrs \\ %{}) do
    {:ok, model} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> CarDealership.Models.create_model()

    model
  end
end
