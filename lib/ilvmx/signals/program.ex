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
  def cmd(function) do
    program = %Program{
      unique: Castle.uuid,
        code: function
    }
    
    #todo: quote the function

    program
  end
  
  @doc ""
  def exe(program = %Signal{}) do
    IO.inspect "xxx))) #{inspect program}"

    program
  end
  
  @doc "Compile or start `program_path` from disk."
  def app(program_path) do
    if Castle.Wizard.valid_path?(program_path) && File.exists?(program_path) do
      Code.eval_file program_path
    end
  end
  
end


