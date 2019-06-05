defmodule SunulatorWeb.PageController do
  use SunulatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
