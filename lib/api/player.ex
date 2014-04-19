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
    bot |> arrow!
  end
  def arrow!(bot = Bot[]) do
    bot |> Castle.exe!
  end
  
  @doc """
  Send a Cupcake message into the Castle and stream results. Good for caps
  and sigs.
  
  Spawn |> Wait |> Event[unique: uuid] |> End
  """
  def dove(cupcake) do
    bot = Bot.w
    bot = bot.player(p1)
    bot = bot.cupcake(cupcake)
    bot |> Castle.cmd
  end
  def dove(bot = Bot[]) do
    bot |> Castle.cmd
  end
  # 
  # # 
  # @doc """
  # Dispatch or call the Bot as a long running app.
  # 
  # Spawn |> Event[unique: uuid] |> Loop
  # """
  # def spell!(bot = Bot[], castle = Castle) do
  #   # # grab the nub from midair..
  #   # 
  #   # # are we a function?
  #   # case is_function bot.cupcake do
  #   #   true  -> bot.cupcake.([bot: bot, nub: nub])
  #   #   false -> nub
  #   # end
  #   
  #   # bender = fn cmd ->
  #   #   cmd.()
  #   # end
  #   # 
  #   # cake = Cupcake.new
  #   # 
  #   # cmds = String.split(cupake, "\n")
  #   # |> Enum.map fn command -> 
  #   #   cmd = String.slice(String.lstrip(command), 0..3)
  #   #   arg = String.replace(cmd, cmd <> " ", "")
  #   # 
  #   #   sugar(cmd, arg).()
  #   # end
  #   # 
  #   # Bot.w(cupcake: cake.commands(cmds))
  #   # |> Castle.arrow!
  # end  

end