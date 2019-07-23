defmodule Sunulator.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias Sunulator.Repo
  alias Sunulator.Locations.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end

  alias Sunulator.Locations.Illumination

  @doc """
  Returns the list of illuminations.

  ## Examples

      iex> list_illuminations()
      [%Illumination{}, ...]

  """
  def list_illuminations do
    Repo.all(Illumination)
  end

  @doc """
  Gets a single illumination.

  Raises `Ecto.NoResultsError` if the Illumination does not exist.

  ## Examples

      iex> get_illumination!(123)
      %Illumination{}

      iex> get_illumination!(456)
      ** (Ecto.NoResultsError)

  """
  def get_illumination!(id), do: Repo.get!(Illumination, id)

  @doc """
  Creates a illumination.

  ## Examples

      iex> create_illumination(%{field: value})
      {:ok, %Illumination{}}

      iex> create_illumination(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_illumination(attrs \\ %{}) do
    %Illumination{}
    |> Illumination.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a illumination.

  ## Examples

      iex> update_illumination(illumination, %{field: new_value})
      {:ok, %Illumination{}}

      iex> update_illumination(illumination, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_illumination(%Illumination{} = illumination, attrs) do
    illumination
    |> Illumination.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Illumination.

  ## Examples

      iex> delete_illumination(illumination)
      {:ok, %Illumination{}}

      iex> delete_illumination(illumination)
      {:error, %Ecto.Changeset{}}

  """
  def delete_illumination(%Illumination{} = illumination) do
    Repo.delete(illumination)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking illumination changes.

  ## Examples

      iex> change_illumination(illumination)
      %Ecto.Changeset{source: %Illumination{}}

  """
  def change_illumination(%Illumination{} = illumination) do
    Illumination.changeset(illumination, %{})
  end
end
