defmodule Sunulator.Repo do
  use Ecto.Repo,
    otp_app: :sunulator,
    adapter: Ecto.Adapters.Postgres
end
