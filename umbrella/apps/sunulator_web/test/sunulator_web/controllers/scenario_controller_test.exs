defmodule SunulatorWeb.ScenarioControllerTest do
  use SunulatorWeb.ConnCase

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all scenarios", %{conn: conn} do
      conn = get(conn, Routes.scenario_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Scenarios"
    end
  end

  describe "new scenario" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.scenario_path(conn, :new))
      assert html_response(conn, 200) =~ "New Scenario"
    end
  end

  describe "create scenario" do
    setup [:create_location]

    test "redirects to show when data is valid", %{conn: conn, location: location} do
      conn = post(conn, Routes.scenario_path(conn, :create), scenario: Map.put(@create_attrs, :location_id, location.id))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.scenario_path(conn, :show, id)

      conn = get(conn, Routes.scenario_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Scenario"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.scenario_path(conn, :create), scenario: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Scenario"
    end
  end

  describe "edit scenario" do
    setup [:create_scenario]

    test "renders form for editing chosen scenario", %{conn: conn, scenario: scenario} do
      conn = get(conn, Routes.scenario_path(conn, :edit, scenario))
      assert html_response(conn, 200) =~ "Edit Scenario"
    end
  end

  describe "update scenario" do
    setup [:create_scenario]

    test "redirects when data is valid", %{conn: conn, scenario: scenario} do
      conn = put(conn, Routes.scenario_path(conn, :update, scenario), scenario: @update_attrs)
      assert redirected_to(conn) == Routes.scenario_path(conn, :show, scenario)

      conn = get(conn, Routes.scenario_path(conn, :show, scenario))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, scenario: scenario} do
      conn = put(conn, Routes.scenario_path(conn, :update, scenario), scenario: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Scenario"
    end
  end

  describe "delete scenario" do
    setup [:create_scenario]

    test "deletes chosen scenario", %{conn: conn, scenario: scenario} do
      conn = delete(conn, Routes.scenario_path(conn, :delete, scenario))
      assert redirected_to(conn) == Routes.scenario_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.scenario_path(conn, :show, scenario))
      end
    end
  end

  defp create_scenario(_), do: {:ok, scenario: Fixtures.Simulations.Scenario.insert!()}
  defp create_location(_), do: {:ok, location: Fixtures.Locations.Location.insert!()}
end
