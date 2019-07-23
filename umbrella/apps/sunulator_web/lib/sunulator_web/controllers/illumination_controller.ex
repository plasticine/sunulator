defmodule SunulatorWeb.IlluminationController do
  use SunulatorWeb, :controller

  alias Sunulator.Locations
  alias Sunulator.Locations.Illumination

  def index(conn, _params) do
    illuminations = Locations.list_illuminations()
    render(conn, "index.html", illuminations: illuminations)
  end

  def new(conn, _params) do
    changeset = Locations.change_illumination(%Illumination{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"illumination" => illumination_params}) do
    case Locations.create_illumination(illumination_params) do
      {:ok, illumination} ->
        conn
        |> put_flash(:info, "Illumination created successfully.")
        |> redirect(to: Routes.illumination_path(conn, :show, illumination))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    illumination = Locations.get_illumination!(id)
    render(conn, "show.html", illumination: illumination)
  end

  def edit(conn, %{"id" => id}) do
    illumination = Locations.get_illumination!(id)
    changeset = Locations.change_illumination(illumination)
    render(conn, "edit.html", illumination: illumination, changeset: changeset)
  end

  def update(conn, %{"id" => id, "illumination" => illumination_params}) do
    illumination = Locations.get_illumination!(id)

    case Locations.update_illumination(illumination, illumination_params) do
      {:ok, illumination} ->
        conn
        |> put_flash(:info, "Illumination updated successfully.")
        |> redirect(to: Routes.illumination_path(conn, :show, illumination))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", illumination: illumination, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    illumination = Locations.get_illumination!(id)
    {:ok, _illumination} = Locations.delete_illumination(illumination)

    conn
    |> put_flash(:info, "Illumination deleted successfully.")
    |> redirect(to: Routes.illumination_path(conn, :index))
  end
end
