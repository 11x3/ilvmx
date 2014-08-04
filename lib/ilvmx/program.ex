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
  def exe(program) do
    IO.inspect "XXX))) #{inspect program}"
    
    # map Program
    #     \compile program
    #     \ unquote functions
    #     \ parse cakedown
    #   \execute program
    #   \pull data out of program
    #   \store program.data into signal.items {:item, x}

    
    # |> Program.compile
    # |> Program.before
    # |> Program.main
    # |> Program.after
    
    program.data[:signal]
  end
  

  
  ## Dynamic
  
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
  
  
  ## Static
  
  @doc "Compile or start `program_path` from disk."
  def app(program_path) do
    if Castle.Wizard.valid_path?(program_path) && File.exists?(program_path) do
      Code.eval_file program_path
    end
  end
  
end


