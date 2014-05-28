defmodule Bot do
  defstruct program: nil,
            results: [],           
             errors: [],
            storage: nil,
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil

  # API
  
  @doc """
  Execute `nubspace` with `program`. 
  """
  def exe(program) do
    bot = %Bot{
       program: program,
        unique: ILVMX.Castle.Server.uuid,
       storage: HashDict.new
    } 
    bot |> ILVMX.Castle.CPU.Server.execute!
  end
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def set(nubspace, item) do
    ILVMX.Nubspace.Server.push!(nubspace, item)
  end
  
  @doc """
  Get a `nub` from `nubspace`.
  """
  def get(nubspace) do
    ILVMX.Nubspace.Server.pull!(nubspace)
  end
  
  @doc """
  Capture a `nubspace` and evaluate nubcake when signaled.
  
  Returns `bot`.
  """
  def cap(nubspace, program) do
    ILVMX.Castle.Tower.Server.capture!(nubspace, program)
  end

  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    %{ bot | results: Enum.concat(bot.results, [effect]) }
  end
end