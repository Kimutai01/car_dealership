defmodule CarDealership.DrivesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarDealership.Drives` context.
  """

  @doc """
  Generate a drive.
  """
  def drive_fixture(attrs \\ %{}) do
    {:ok, drive} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        email: "some email",
        phone_number: "some phone_number"
      })
      |> CarDealership.Drives.create_drive()

    drive
  end
end
