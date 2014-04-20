defrecord Bot, 
   cupcake: nil,
       tmp: nil,
    player: nil,
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil do        # callback
  

  # API/Sugar
  
  @doc """
  Shortcut to create a bot.
  """
  def w(cupcake \\ nil) do
    apply __MODULE__, :new, [[
       cupcake: cupcake,
        unique: Castle.uuid,
           tmp: HashDict.new
    ]]
  end
  
  @doc """
  "Oh you know, the usual.." create + cmd!
  """
  def cmd!(cupcake) do
    Bot.w(cupcake) |> ILM.Castle.Dungeon.execute!
  end

  @doc """
  Get a `Cupcake` from `nubspace`.
  """
  def get(nubspace) do
    Bot.cmd! fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Store `cupcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, cupcake) do
    Bot.cmd! fn ->
      ILM.Nubspace.push! nubspace, cupcake
    end
  end
  
  @doc """
  Execute a `nubspace` and evaluate `cupcake`.
  
  Returns `bot`.
  """
  def exe(nubspace, cupcake) do
    ILM.Castle.Dungeon.execute! Bot.w, cupcake, nubspace
  end
  
  @doc """
  Capture a `nubspace` and evaluate cupcake.
  
  Returns `bot`.
  """
  def cap(nubspace, cupcake) do
    Bot.cmd! fn ->
      ILM.Tower.capture! nubspace, cupcake
    end
  end
  

  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    bot.results(Enum.concat(bot.results, [effect]))
  end
end