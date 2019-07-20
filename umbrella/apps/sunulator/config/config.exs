# Since configuration is shared in umbrella projects, this file
# should only configure the :sunulator application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :sunulator,
  ecto_repos: [Sunulator.Repo]

config :sunulator, Sunulator.Repo, migration_primary_key: [name: :id, type: :binary_id]

config :phoenix, :generators,
  migration: true,
  binary_id: true,
  sample_binary_id: "11111111-1111-1111-1111-111111111111"

import_config "#{Mix.env()}.exs"
