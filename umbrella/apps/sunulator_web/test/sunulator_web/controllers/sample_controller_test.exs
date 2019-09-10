defmodule SunulatorWeb.SampleControllerTest do
  use SunulatorWeb.ConnCase

  @create_attrs %{interval_type: :half_hour, interval: 1, beam: 120.5, bulb_temp: 120.5, day: 42, diffuse: 120.5}
  @update_attrs %{interval_type: :half_hour, interval: 2, beam: 456.7, bulb_temp: 456.7, day: 43, diffuse: 456.7}
  @invalid_attrs %{interval_type: nil, interval: nil, beam: nil, bulb_temp: nil, day: nil, diffuse: nil}

  describe "index" do
    test "lists all samples", %{conn: conn} do
      conn = get(conn, Routes.sample_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Samples"
    end
  end

  describe "new sample" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sample_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sample"
    end
  end

  describe "create sample" do
    setup [:create_location]

    test "redirects to show when data is valid", %{conn: conn, location: location} do
      conn = post(conn, Routes.sample_path(conn, :create), sample: Map.put(@create_attrs, :location_id, location.id))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sample_path(conn, :show, id)

      conn = get(conn, Routes.sample_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sample"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sample_path(conn, :create), sample: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sample"
    end
  end

  describe "edit sample" do
    setup [:create_sample]

    test "renders form for editing chosen sample", %{conn: conn, sample: sample} do
      conn = get(conn, Routes.sample_path(conn, :edit, sample))
      assert html_response(conn, 200) =~ "Edit Sample"
    end
  end

  describe "update sample" do
    setup [:create_sample]

    test "redirects when data is valid", %{conn: conn, sample: sample} do
      conn = put(conn, Routes.sample_path(conn, :update, sample), sample: @update_attrs)
      assert redirected_to(conn) == Routes.sample_path(conn, :show, sample)

      conn = get(conn, Routes.sample_path(conn, :show, sample))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, sample: sample} do
      conn = put(conn, Routes.sample_path(conn, :update, sample), sample: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sample"
    end
  end

  describe "delete sample" do
    setup [:create_sample]

    test "deletes chosen sample", %{conn: conn, sample: sample} do
      conn = delete(conn, Routes.sample_path(conn, :delete, sample))
      assert redirected_to(conn) == Routes.sample_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sample_path(conn, :show, sample))
      end
    end
  end

  defp create_location(_), do: {:ok, location: Fixtures.Locations.Location.insert!()}
  defp create_sample(_), do: {:ok, sample: Fixtures.Locations.Sample.insert!()}
end
