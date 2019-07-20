defmodule Sunulator.SimulationsTest do
  use Sunulator.DataCase

  alias Sunulator.Simulations

  describe "scenarios" do
    alias Sunulator.Simulations.Scenario

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def scenario_fixture(attrs \\ %{}) do
      {:ok, scenario} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Simulations.create_scenario()

      scenario
    end

    test "list_scenarios/0 returns all scenarios" do
      scenario = scenario_fixture()
      assert Simulations.list_scenarios() == [scenario]
    end

    test "get_scenario!/1 returns the scenario with given id" do
      scenario = scenario_fixture()
      assert Simulations.get_scenario!(scenario.id) == scenario
    end

    test "create_scenario/1 with valid data creates a scenario" do
      assert {:ok, %Scenario{} = scenario} = Simulations.create_scenario(@valid_attrs)
      assert scenario.name == "some name"
    end

    test "create_scenario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Simulations.create_scenario(@invalid_attrs)
    end

    test "update_scenario/2 with valid data updates the scenario" do
      scenario = scenario_fixture()
      assert {:ok, %Scenario{} = scenario} = Simulations.update_scenario(scenario, @update_attrs)
      assert scenario.name == "some updated name"
    end

    test "update_scenario/2 with invalid data returns error changeset" do
      scenario = scenario_fixture()
      assert {:error, %Ecto.Changeset{}} = Simulations.update_scenario(scenario, @invalid_attrs)
      assert scenario == Simulations.get_scenario!(scenario.id)
    end

    test "delete_scenario/1 deletes the scenario" do
      scenario = scenario_fixture()
      assert {:ok, %Scenario{}} = Simulations.delete_scenario(scenario)
      assert_raise Ecto.NoResultsError, fn -> Simulations.get_scenario!(scenario.id) end
    end

    test "change_scenario/1 returns a scenario changeset" do
      scenario = scenario_fixture()
      assert %Ecto.Changeset{} = Simulations.change_scenario(scenario)
    end
  end
end
