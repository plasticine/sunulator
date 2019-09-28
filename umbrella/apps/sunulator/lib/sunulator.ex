defmodule Sunulator do
  @moduledoc """
  Sunulator keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defmodule IExUtils do
    @doc """
    Utility method to find globally by UUID.
    """
    def find!(uuid) do
      {:ok, modules} = :application.get_key(:sunulator, :modules)

      modules
      |> Stream.filter(&({:__schema__, 1} in &1.__info__(:functions)))
      |> Stream.map(fn schema -> Sunulator.Repo.get(schema, uuid) end)
      |> Stream.reject(&Kernel.is_nil/1)
      |> Enum.take(1)
      |> Enum.at(0)
    end
  end
end
