require Logger

defmodule Program do
  defstruct source: nil,
              code: nil,  # expression
              data: %{},  # storage
           effects: [],
            errors: [],   # exceptions or manual logged errors
            unique: nil

  @moduledoc """
  Programming Program [wip][betabook]
  #todo: returns `Signal`
  """
  
  ## API
  
  @doc "Execute a `function`"
  def cmd(program) when is_function(program) do
    #todo: quote the function for transport
    program = %Program{
      unique: Castle.uuid,
        code: program
    }
    program
  end
  
  def exe(signal = %Signal{}, item = %Signal{let: %Program{}}) do
    Logger.debug ".x.x..Program.exe/signal: #{inspect signal}"
    Logger.debug ".x.x..Program.exe/signal/item: #{inspect item}"
    
    result = Task.async(fn -> item.let.code.(signal) end) |> Task.await
        
    #todo: pass signal into program
    Signal.boost!(signal, result)
  end
  def exe(signal = %Signal{}, _signal = %Signal{let: item = %Item{}}) do
    Logger.debug ".x.x..Program.exe/signal/item: #{inspect item}"
    
    #todo: pass signal into program
    Signal.boost!(signal, item)
  end
  def exe(signal = %Signal{}, item) do
    Logger.debug ".x.x..Program.exe/item: #{inspect item}"
    
    #todo: pass signal into program
    Signal.boost!(signal, item)
  end
  def exe(signal, []) do
    Logger.debug ".x.x..Program.exe/[]"
    
    signal
  end
    
end


