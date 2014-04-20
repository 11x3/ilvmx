# Castle-level Nubs (owners/people).
defrecord Player,
  nubspace: nil,   # exchange/home/mynub
   signals: [],         # custom pipes/scripts
      bots: [],         # real-time :demand route matchers
    maybes: [],         # # keyword list of okcupid-like data
  cupcakes: [] do       
   
  def p1 do
    new
  end

  @doc """
  Send a Cupcake message into the Castle and ignore results.
  
  Spawn |> Event[unique: uuid]
  
  todo: support galactic castles.
  """
  def arrow!(cupcake) when is_binary(cupcake) do
    bot = Bot.w
    bot = bot.player(Player.new)
    bot = bot.cupcake(cupcake)
    bot |> take |> arrow!
  end
  def arrow!(bot = Bot[]) do
    bot |> take |> Castle.upload!
  end
  
  defp take(bot) do
    bot = bot.player(Player.new)
  end
end