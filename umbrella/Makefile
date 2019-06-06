deps:
	mix deps.get

compile:
	mix compile

assets:
	cd apps/sunulator_web/assets && yarn

bootstrap: | deps assets compile db.reset

up:
	iex -S mix phx.server

up.assets:
	cd apps/sunulator_web/assets && yarn watch

db.drop:
	mix do ecto.drop

db.setup: | db.drop
	mix do ecto.create, ecto.migrate, run apps/sunulator/priv/repo/seeds.exs

db.reset: | db.drop db.setup


.PHONY: deps compile
