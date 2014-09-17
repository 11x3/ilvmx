require Logger

defmodule Program do
  defstruct   item: nil,
              code: nil,  # expression
              data: %{},  # storage
           effects: [],
            errors: [],   # exceptions or manual logged errors
            unique: nil
            
  @moduledoc """
  #todo: Programming Cakedown [wip][betabook]
  """
  
  ## API
  
  @doc "Enclose `code` and return Program."
  def cmd(code) when is_function(code) do
    #todo: quote the function for transport
    program = %Program{
      unique: Castle.uuid,
        code: code
    }
  end
  
  
  @doc "Execute a signa/function."
  def exe(signal = %Signal{}, program = %Signal{item: %Program{}}) do    
    Signal.boost(signal, Task.async(fn ->
      program.item.code.(signal) 
    end) |> Task.await)
  end
  def exe(signal = %Signal{}, _signal = %Signal{item: item = %Item{}}) do    
    Signal.boost(signal, item)
  end
  def exe(signal = %Signal{}, item) do    
    Signal.boost(signal, item)
  end
  def exe(signal, []) do    
    signal
  end
    
end


