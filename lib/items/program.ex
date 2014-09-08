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
  @doc "Exe raw Cakedown text."   
  def raw(text) do
    program = %Program{
      unique: Castle.uuid,
        code: text
    }
    
    #todo: convert source into code
    
    program
  end
  
  @doc "Execute a `function`"
  def exe(program) when is_function(program) do
    program = %Program{
      unique: Castle.uuid,
        code: program
    }
    
    #todo: quote the function

    program
  end
  
  def exe(signal, item = %Program{}) do
    
    signal
  end
  def exe(signal, item) do
    #todo: exe each item for results
    
    signal
  end
  
  @doc ""
  def exe(program = %Signal{}, duration, auto) do
    
    program
  end
    
end


