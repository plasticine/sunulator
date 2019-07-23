defmodule SunulatorWeb.IlluminationControllerTest do
  use SunulatorWeb.ConnCase

  alias Sunulator.Locations

  @create_attrs %{beam: 120.5, bulb_temp: 120.5, day: 42, diffuse: 120.5, month: 42, sample_date: ~N[2010-04-17 14:00:00], year: 42}
  @update_attrs %{beam: 456.7, bulb_temp: 456.7, day: 43, diffuse: 456.7, month: 43, sample_date: ~N[2011-05-18 15:01:01], year: 43}
  @invalid_attrs %{beam: nil, bulb_temp: nil, day: nil, diffuse: nil, month: nil, sample_date: nil, year: nil}

  def fixture(:illumination) do
    {:ok, illumination} = Locations.create_illumination(@create_attrs)
    illumination
  end

  describe "index" do
    test "lists all illuminations", %{conn: conn} do
      conn = get(conn, Routes.illumination_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Illuminations"
    end
  end

  describe "new illumination" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.illumination_path(conn, :new))
      assert html_response(conn, 200) =~ "New Illumination"
    end
  end

  describe "create illumination" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.illumination_path(conn, :create), illumination: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.illumination_path(conn, :show, id)

      conn = get(conn, Routes.illumination_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Illumination"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.illumination_path(conn, :create), illumination: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Illumination"
    end
  end

  describe "edit illumination" do
    setup [:create_illumination]

    test "renders form for editing chosen illumination", %{conn: conn, illumination: illumination} do
      conn = get(conn, Routes.illumination_path(conn, :edit, illumination))
      assert html_response(conn, 200) =~ "Edit Illumination"
    end
  end

  describe "update illumination" do
    setup [:create_illumination]

    test "redirects when data is valid", %{conn: conn, illumination: illumination} do
      conn = put(conn, Routes.illumination_path(conn, :update, illumination), illumination: @update_attrs)
      assert redirected_to(conn) == Routes.illumination_path(conn, :show, illumination)

      conn = get(conn, Routes.illumination_path(conn, :show, illumination))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, illumination: illumination} do
      conn = put(conn, Routes.illumination_path(conn, :update, illumination), illumination: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Illumination"
    end
  end

  describe "delete illumination" do
    setup [:create_illumination]

    test "deletes chosen illumination", %{conn: conn, illumination: illumination} do
      conn = delete(conn, Routes.illumination_path(conn, :delete, illumination))
      assert redirected_to(conn) == Routes.illumination_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.illumination_path(conn, :show, illumination))
      end
    end
  end

  defp create_illumination(_) do
    illumination = fixture(:illumination)
    {:ok, illumination: illumination}
  end
end
