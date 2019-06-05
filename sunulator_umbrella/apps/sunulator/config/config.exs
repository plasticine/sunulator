# Since configuration is shared in umbrella projects, this file
# should only configure the :sunulator application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :sunulator,
  ecto_repos: [Sunulator.Repo]

import_config "#{Mix.env()}.exs"
