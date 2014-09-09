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
    IO.inspect ".x.x..Program.exe/signal: #{inspect signal}"
    IO.inspect ".x.x..Program.exe/signal/item: #{inspect item}"
    
    #todo: pass signal into program
    Signal.boost!(signal, item.let.code.(signal))
  end
  def exe(signal = %Signal{}, _signal = %Signal{let: item = %Item{}}) do
    IO.inspect ".x.x..Program.exe/signal/item: #{inspect item}"
    
    #todo: pass signal into program
    Signal.boost!(signal, item)
  end
  def exe(signal = %Signal{}, item) do
    IO.inspect ".x.x..Program.exe/item: #{inspect item}"
    
    #todo: pass signal into program
    Signal.boost!(signal, item)
  end
  def exe(signal, []) do
    IO.inspect ".x.x..Program.exe/[]"
    
    signal
  end
    
end


