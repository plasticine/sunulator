# Since configuration is shared in umbrella projects, this file
# should only configure the :sunulator_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :sunulator_web,
  ecto_repos: [Sunulator.Repo],
  generators: [context_app: :sunulator]

# Configures the endpoint
config :sunulator_web, SunulatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eOx07gByfnRHbUbU5+0hiWLTKU0XUadMRPa0glcxwa2Qt/xGIJ9iuqGpwriRZPnW",
  render_errors: [view: SunulatorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SunulatorWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
