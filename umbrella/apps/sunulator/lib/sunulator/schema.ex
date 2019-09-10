defmodule Sunulator.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Query, only: [from: 2]
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
