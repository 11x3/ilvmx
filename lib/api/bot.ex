defmodule Bot do
  defstruct program: nil,
            results: [],           
             errors: [],
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil

  # API
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def set(nubspace, prop) do
    Nubspace.push! nubspace, prop
  end
  
  @doc """
  Get a `nub` from `nubspace`.
  """
  def get(nubspace) do
    Nubspace.pull! nubspace
  end
  def get(:static, path) do
    Prop.static path
  end
  def get(:web, path) do
    Prop.web path
  end

  @doc """
  Capture a `nubspace` and evaluate `program` when signaled.
  """
  def cap(nubspace, program) do
    ILM.Castle.Tower.capture! nubspace, program
  end
  
  @doc """
  Execute `program`.
  """
  def exe(program) when is_binary(program) do
    bot = %Bot{
      program: program,
       unique: Castle.uuid
    } |> ILM.Castle.Dungeon.execute!
  end
  def exe(commands) when is_list(commands) do
    bot = %Bot{
      program: Program.cmp(commands),
       unique: Castle.uuid
    } |> ILM.Castle.Dungeon.execute!
  end

  @doc """
  Schedule `program` to run at `nubspace`.
  """
  def api(nubspace, program) when is_binary(program) do
    
  end
  def api(nubspace, function) when is_function(function) do
    
  end
  
  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    %{ bot | results: Enum.concat(bot.results, [effect]) }
  end
end