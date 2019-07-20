defmodule Sunulator.Simulations do
  @moduledoc """
  The Simulations context.
  """

  import Ecto.Query, warn: false
  alias Sunulator.Repo

  alias Sunulator.Simulations.Scenario

  @doc """
  Returns the list of scenarios.

  ## Examples

      iex> list_scenarios()
      [%Scenario{}, ...]

  """
  def list_scenarios do
    Repo.all(Scenario)
  end

  @doc """
  Gets a single scenario.

  Raises `Ecto.NoResultsError` if the Scenario does not exist.

  ## Examples

      iex> get_scenario!(123)
      %Scenario{}

      iex> get_scenario!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scenario!(id), do: Repo.get!(Scenario, id)

  @doc """
  Creates a scenario.

  ## Examples

      iex> create_scenario(%{field: value})
      {:ok, %Scenario{}}

      iex> create_scenario(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scenario(attrs \\ %{}) do
    %Scenario{}
    |> Scenario.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scenario.

  ## Examples

      iex> update_scenario(scenario, %{field: new_value})
      {:ok, %Scenario{}}

      iex> update_scenario(scenario, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scenario(%Scenario{} = scenario, attrs) do
    scenario
    |> Scenario.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Scenario.

  ## Examples

      iex> delete_scenario(scenario)
      {:ok, %Scenario{}}

      iex> delete_scenario(scenario)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scenario(%Scenario{} = scenario) do
    Repo.delete(scenario)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scenario changes.

  ## Examples

      iex> change_scenario(scenario)
      %Ecto.Changeset{source: %Scenario{}}

  """
  def change_scenario(%Scenario{} = scenario) do
    Scenario.changeset(scenario, %{})
  end
end
