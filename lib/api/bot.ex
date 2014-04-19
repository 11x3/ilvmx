defrecord Bot, 
   cupcake: nil,          # contents
    player: nil,
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil do        # callback
  
  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
    
  # API
  
  @doc """
  Store `cupcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, cupcake) do
    Bot.exe nubspace, fn args -> 
      ILM.Nubspace.push! nubspace, cupcake
    end
  end
  
  @doc """
  Get a `Cupcake` from `nubspace`.
  """
  def get(nubspace) do
    # set :commands and spawn
    Bot.exe nubspace, fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Capture a `nubspace` and evaluate cupcake.
  
  Returns `bot`.
  """
  def cap(channel, cupcake) do
    Bot.w channel, fn args ->
      ILM.TowerServer.capture! channel, cupcake
    end
  end
  
  
  @doc """
  Basic do-something bot.
  """
  def exe(nubspace, cupcake) do
    
  end
  
  
  @doc """
  Shortcut to create a bot.
  """
  def w(nubspace \\ nil, cupcake \\ nil) do
    apply __MODULE__, :new, [[
      nubspace: nubspace,
       cupcake: cupcake,
        unique: Castle.uuid
    ]]
  end


  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    bot.results(Enum.concat(bot.results, [effect]))
  end
end