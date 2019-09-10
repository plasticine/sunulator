defmodule SunulatorWeb.SampleController do
  use SunulatorWeb, :controller

  alias Sunulator.Locations
  alias Sunulator.Locations.Sample

  def index(conn, _params) do
    samples = Locations.list_samples()
    render(conn, "index.html", samples: samples)
  end

  def new(conn, _params) do
    changeset = Locations.change_sample(%Sample{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sample" => sample_params}) do
    case Locations.create_sample(sample_params) do
      {:ok, sample} ->
        conn
        |> put_flash(:info, "Sample created successfully.")
        |> redirect(to: Routes.sample_path(conn, :show, sample))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sample = Locations.get_sample!(id)
    render(conn, "show.html", sample: sample)
  end

  def edit(conn, %{"id" => id}) do
    sample = Locations.get_sample!(id)
    changeset = Locations.change_sample(sample)
    render(conn, "edit.html", sample: sample, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sample" => sample_params}) do
    sample = Locations.get_sample!(id)

    case Locations.update_sample(sample, sample_params) do
      {:ok, sample} ->
        conn
        |> put_flash(:info, "Sample updated successfully.")
        |> redirect(to: Routes.sample_path(conn, :show, sample))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sample: sample, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sample = Locations.get_sample!(id)
    {:ok, _sample} = Locations.delete_sample(sample)

    conn
    |> put_flash(:info, "Sample deleted successfully.")
    |> redirect(to: Routes.sample_path(conn, :index))
  end
end
