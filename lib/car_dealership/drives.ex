defmodule CarDealership.Drives do
  @moduledoc """
  The Drives context.
  """

  import Ecto.Query, warn: false
  alias CarDealership.Repo

  alias CarDealership.Drives.Drive

  @doc """
  Returns the list of drives.

  ## Examples

      iex> list_drives()
      [%Drive{}, ...]

  """
  def list_drives do
    Repo.all(Drive)
  end

  @doc """
  Gets a single drive.

  Raises `Ecto.NoResultsError` if the Drive does not exist.

  ## Examples

      iex> get_drive!(123)
      %Drive{}

      iex> get_drive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_drive!(id), do: Repo.get!(Drive, id)

  @doc """
  Creates a drive.

  ## Examples

      iex> create_drive(%{field: value})
      {:ok, %Drive{}}

      iex> create_drive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_drive(attrs \\ %{}) do
    %Drive{}
    |> Drive.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a drive.

  ## Examples

      iex> update_drive(drive, %{field: new_value})
      {:ok, %Drive{}}

      iex> update_drive(drive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_drive(%Drive{} = drive, attrs) do
    drive
    |> Drive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a drive.

  ## Examples

      iex> delete_drive(drive)
      {:ok, %Drive{}}

      iex> delete_drive(drive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_drive(%Drive{} = drive) do
    Repo.delete(drive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking drive changes.

  ## Examples

      iex> change_drive(drive)
      %Ecto.Changeset{data: %Drive{}}

  """
  def change_drive(%Drive{} = drive, attrs \\ %{}) do
    Drive.changeset(drive, attrs)
  end
end
