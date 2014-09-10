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
  
  def exe(signal = %Signal{}, program = %Signal{item: %Program{}}) do
    result = Task.async(fn -> program.item.code.(signal) end) |> Task.await
        
    Signal.boost!(signal, result)
  end
  def exe(signal = %Signal{}, _signal = %Signal{item: item = %Item{}}) do    
    Signal.boost!(signal, item)
  end
  def exe(signal = %Signal{}, item) do    
    Signal.boost!(signal, item)
  end
  def exe(signal, []) do    
    signal
  end
    
end


