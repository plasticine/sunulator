# Since configuration is shared in umbrella projects, this file
# should only configure the :sunulator application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :sunulator, Sunulator.Repo,
  show_sensitive_data_on_connection_error: true,
  username: System.get_env("SUNULATOR_POSTGRES_USERNAME"),
  password: System.get_env("SUNULATOR_POSTGRES_PASSWORD"),
  database: "sunulator_dev",
  hostname: System.get_env("SUNULATOR_POSTGRES_HOSTNAME"),
  pool_size: 10
