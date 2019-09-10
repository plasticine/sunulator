defmodule Sunulator.Fixtures do
  defmodule Fixture do
    @callback create(attrs :: map()) :: :ok

    defmacro __using__(_) do
      quote do
        @behaviour Sunulator.Fixtures.Fixture
        alias Sunulator.Repo
        alias Sunulator.Fixtures

        @doc """
        Convenience method to create and insert in one go.
        """
        def insert!(attrs \\ %{}), do: Repo.insert!(create(attrs))
      end
    end
  end
end
