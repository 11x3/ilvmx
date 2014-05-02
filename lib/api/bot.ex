defmodule Bot do
  defstruct program: nil,
            storage: nil,
            results: [],           
             errors: [],
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil
  
  # Sugar/API

  @doc """
  Get a `Program` from `nubspace`.
  """
  def get(nubspace) do
    Bot.cmd fn ->
      ILM.Nubspace.pull! nubspace
    end
  end
  
  @doc """
  Store `program` at `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, program) do
    Bot.cmd fn ->
      ILM.Nubspace.push! nubspace, program
    end
  end
    
  @doc """
  Capture a `nubspace` and evaluate `program` when signaled.
  
  Returns `bot`.
  """
  def cap(nubspace, program) do
    Bot.cmd fn ->
      ILM.Tower.capture! nubspace, program
    end
  end
  
  @doc """
  Execute `nubspace` with `program`. 
  """
  def exe(nubspace, program \\ nil) do
    bot = %Bot{
       program: program,
       storage: HashDict.new,
        unique: Castle.uuid,
    } 
    bot |> ILM.Castle.Dungeon.execute! bot.program, nubspace
  end
  
  @doc """
  Execute Program. 
  
  "Oh you know, the usual.."
  """
  def cmd(program) do
    bot = %Bot{
       program: program,
       storage: HashDict.new,
        unique: Castle.uuid,
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