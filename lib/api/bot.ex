defmodule Bot do
  defstruct nubcake:  nil,
            tmp:      nil,
            player:   nil,
            results:  [],           
            problems: [],
            accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
            unique:   nil
  
  # Sugar/API

  @doc """
  Get a `Nubcake` from `nubspace`.
  """
  def get(nubspace) do
    Bot.exe fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Store `nubcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, nubcake) do
    Bot.exe fn ->
      ILM.Nubspace.push! nubspace, nubcake
    end
  end
    
  @doc """
  Capture a `nubspace` and evaluate nubcake.
  
  Returns `bot`.
  """
  def cap(nubspace, nubcake) do
    Bot.exe fn ->
      ILM.Tower.capture! nubspace, nubcake
    end
  end
  

  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    %{ bot | results: Enum.concat(bot.results, [effect]) }
  end


  @doc """
  Execute Nubcake. 
  
  "Oh you know, the usual.."
  """
  def exe(nubcake) do
    bot = %Bot{
       nubcake: nubcake,
        unique: Castle.uuid,
           tmp: HashDict.new
    } 
    
    bot |> ILM.Castle.Dungeon.execute!
  end

end