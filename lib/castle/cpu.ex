defmodule ILvMx.Castle.CPU do
  use GenServer.Behaviour
  
  @doc """
  *Shh...*
  """
  def execute!(bot) do    
    try do
      bot |> Program.run
    rescue 
      x in [BadFunctionError, RuntimeError, ArgumentError, BadArityError] -> 
        Bot.effect bot, Effect.w error: x
    end
    bot
  end

  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end