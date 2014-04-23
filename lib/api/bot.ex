defmodule Bot do
  defstruct nubcake:  nil,
            tmp:      nil,
            player:   nil,
            results:  [],           
            problems: [],
            accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
            unique:   nil
  
  # Sugar
  
  @doc """
  Shortcut to create a bot.
  """
  def w(nubcake \\ nil) do
    apply __MODULE__, :new, [[
       nubcake: nubcake,
        unique: Castle.uuid,
           tmp: HashDict.new
    ]]
  end
  
  @doc """
  "Oh you know, the usual.." create + cmd!
  """
  def cmd!(nubcake) do
    Bot.w(nubcake) |> ILM.Castle.Dungeon.execute!
  end


  # API
  
  @doc """
  Get a `Nubcake` from `nubspace`.
  """
  def get(nubspace) do
    Bot.cmd! fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Store `nubcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, nubcake) do
    Bot.cmd! fn ->
      ILM.Nubspace.push! nubspace, nubcake
    end
  end
  
  @doc """
  Execute a `nubspace` and evaluate `nubcake`.
  
  Returns `bot`.
  """
  def exe(nubspace, nubcake) do
    ILM.Castle.Dungeon.execute! Bot.w, nubcake, nubspace
  end
  
  @doc """
  Capture a `nubspace` and evaluate nubcake.
  
  Returns `bot`.
  """
  def cap(nubspace, nubcake) do
    Bot.cmd! fn ->
      ILM.Tower.capture! nubspace, nubcake
    end
  end
  

  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    bot.results(Enum.concat(bot.results, [effect]))
  end
end