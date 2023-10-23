defmodule CarDealership.Models do
  @moduledoc """
  The Models context.
  """

  import Ecto.Query, warn: false
  alias CarDealership.Repo

  alias CarDealership.Models.Model

  @doc """
  Returns the list of models.

  ## Examples

      iex> list_models()
      [%Model{}, ...]

  """
  def list_models do
    Repo.all(Model) |> Repo.preload(:quotes) |> Repo.preload(:category) |> Repo.preload(:drives)
  end

  @doc """
  Gets a single model.

  Raises `Ecto.NoResultsError` if the Model does not exist.

  ## Examples

      iex> get_model!(123)
      %Model{}

      iex> get_model!(456)
      ** (Ecto.NoResultsError)

  """
  def get_model!(id),
    do:
      Repo.get!(Model, id)
      |> Repo.preload(:quotes)
      |> Repo.preload(:category)
      |> Repo.preload(:drives)

  @doc """
  Creates a model.

  ## Examples

      iex> create_model(%{field: value})
      {:ok, %Model{}}

      iex> create_model(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_model(attrs \\ %{}) do
    %Model{}
    |> Model.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a model.

  ## Examples

      iex> update_model(model, %{field: new_value})
      {:ok, %Model{}}

      iex> update_model(model, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_model(%Model{} = model, attrs) do
    model
    |> Model.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a model.

  ## Examples

      iex> delete_model(model)
      {:ok, %Model{}}

      iex> delete_model(model)
      {:error, %Ecto.Changeset{}}

  """
  def delete_model(%Model{} = model) do
    Repo.delete(model)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking model changes.

  ## Examples

      iex> change_model(model)
      %Ecto.Changeset{data: %Model{}}

  """
  def change_model(%Model{} = model, attrs \\ %{}) do
    Model.changeset(model, attrs)
  end

  def filter_model(category_id, minimum_price, maximum_price) do
    query =
      from m in Model,
        where: m.category_id == ^category_id,
        where: m.price >= ^minimum_price,
        where: m.price <= ^maximum_price,
        select: m

    Repo.all(query)
  end

  def get_models_by_body_type(body_type) do
    query =
      from m in Model,
        where: m.body_type == ^body_type,
        select: m

    Repo.all(query)
  end

  def get_featured_cars() do
    query =
      from m in Model,
        where: m.is_featured == true,
        select: m

    Repo.all(query)
  end

  def get_latest_cars() do
    query =
      from m in Model,
        order_by: [desc: m.inserted_at],
        select: m,
        limit: 4

    Repo.all(query)
  end

  def paginate_models(params) do
    Repo.paginate(Model, params)
  end
end
