defmodule SunulatorWeb.Router do
  use SunulatorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SunulatorWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/regions", RegionController
    resources "/locations", LocationController
    resources "/scenarios", ScenarioController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SunulatorWeb do
  #   pipe_through :api
  # end
end
