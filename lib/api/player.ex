defmodule Player do
defstruct nubspace: nil, # "home" castle (ie. connection to :ilvmx galaxy)
           wizards: [],  # custom pipes/scripts
              bots: [],  # programs (see: bot.ex)
             polls: []   # keyword list of okcupid-like data
          
  @moduledoc """
  Castle-level accounts.
  """

  @doc """
  Send a Program message into the Castle and ignore results.
  
  Spawn |> Event[unique: uuid]
  
  todo: support galactic castles.
  """
  def arrow!(program) when is_binary(program) do
    bot = Bot.w
    bot = bot.player(Player.new)
    bot = bot.program(program)
    bot |> take |> arrow!
  end
  def arrow!(bot = Bot) do
    bot |> take |> Dungeon.execute!
  end
  
  defp take(bot) do
    bot = bot.player(Player.new)
  end
end