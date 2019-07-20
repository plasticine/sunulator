defmodule SunulatorWeb.ScenarioController do
  use SunulatorWeb, :controller

  alias Sunulator.Simulations
  alias Sunulator.Simulations.Scenario

  def index(conn, _params) do
    scenarios = Simulations.list_scenarios()
    render(conn, "index.html", scenarios: scenarios)
  end

  def new(conn, _params) do
    changeset = Simulations.change_scenario(%Scenario{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scenario" => scenario_params}) do
    case Simulations.create_scenario(scenario_params) do
      {:ok, scenario} ->
        conn
        |> put_flash(:info, "Scenario created successfully.")
        |> redirect(to: Routes.scenario_path(conn, :show, scenario))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scenario = Simulations.get_scenario!(id)
    render(conn, "show.html", scenario: scenario)
  end

  def edit(conn, %{"id" => id}) do
    scenario = Simulations.get_scenario!(id)
    changeset = Simulations.change_scenario(scenario)
    render(conn, "edit.html", scenario: scenario, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scenario" => scenario_params}) do
    scenario = Simulations.get_scenario!(id)

    case Simulations.update_scenario(scenario, scenario_params) do
      {:ok, scenario} ->
        conn
        |> put_flash(:info, "Scenario updated successfully.")
        |> redirect(to: Routes.scenario_path(conn, :show, scenario))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", scenario: scenario, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scenario = Simulations.get_scenario!(id)
    {:ok, _scenario} = Simulations.delete_scenario(scenario)

    conn
    |> put_flash(:info, "Scenario deleted successfully.")
    |> redirect(to: Routes.scenario_path(conn, :index))
  end
end
