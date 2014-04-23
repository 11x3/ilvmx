defmodule Player do
defstruct nubspace: nil,  # exchange/home
          signals:  [],   # custom pipes/scripts
          bots:     [],   # real-time :demand route matchers
          maybes:   [],   # # keyword list of okcupid-like data
          nubcakes: []     
   
  def p1 do
    new
  end
  
  @moduledoc """
  Castle-level accounts.
  """

  @doc """
  Send a Nubcake message into the Castle and ignore results.
  
  Spawn |> Event[unique: uuid]
  
  todo: support galactic castles.
  """
  def arrow!(nubcake) when is_binary(nubcake) do
    bot = Bot.w
    bot = bot.player(Player.new)
    bot = bot.nubcake(nubcake)
    bot |> take |> arrow!
  end
  def arrow!(bot = Bot[]) do
    bot |> take |> Dungeon.execute!
  end
  
  defp take(bot) do
    bot = bot.player(Player.new)
  end
end