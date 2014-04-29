defmodule Bot do
  defstruct nubcake: nil,
            storage: nil,
            results: [],           
             errors: [],
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil
  
  # Sugar/API

  @doc """
  Get a `Nubcake` from `nubspace`.
  """
  def get(nubspace) do
    Bot.cmd fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Store `nubcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, nubcake) do
    Bot.cmd fn ->
      ILM.Nubspace.push! nubspace, nubcake
    end
  end
    
  @doc """
  Capture a `nubspace` and evaluate nubcake when signaled.
  
  Returns `bot`.
  """
  def cap(nubspace, nubcake) do
    Bot.cmd fn ->
      ILM.Tower.capture! nubspace, nubcake
    end
  end
  
  @doc """
  Execute `nubspace` with `nubcake`. 
  """
  def exe(nubspace, nubcake \\ nil) do
    bot = %Bot{
       nubcake: nubcake,
        unique: Castle.uuid,
       storage: HashDict.new
    } 
    bot |> ILM.Castle.Dungeon.execute! bot.nubcake, nubspace
  end
  
  @doc """
  Execute Nubcake. 
  
  "Oh you know, the usual.."
  """
  def cmd(nubcake) do
    bot = %Bot{
       nubcake: nubcake,
        unique: Castle.uuid,
       storage: HashDict.new
    }
    bot |> ILM.Castle.Dungeon.execute!
  end
  
  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    %{ bot | results: Enum.concat(bot.results, [effect]) }
  end

end