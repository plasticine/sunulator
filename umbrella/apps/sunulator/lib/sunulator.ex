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
    def find!(_uuid) do
      # IO.inspect uuid

      {:ok, modules} = :application.get_key(:sunulator, :modules)

      modules
      |> Enum.filter(&({:__schema__, 1} in &1.__info__(:functions)))
      |> Enum.ma
    end
  end
end
