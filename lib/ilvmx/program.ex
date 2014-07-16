defmodule Program do
  defstruct   code: nil,  # expression
              data: %{},  # storage
            errors: [],   # exceptions or manual logged errors
            unique: nil

  @moduledoc """
  Programming Program [wip][betabook]
  """
  @doc "Exe Cakedown text."   
  def raw(text) do
    program = %Program{
      unique: ILM.Castle.uuid,
        code: text
    }
    
    #todo: convert source into code
    
    program
  end
  
  @doc "Execute a `function`"
  def cmd(function) do
    program = %Program{
      unique: ILM.Castle.uuid,
        code: function
    }

    program
  end
    
  @doc "Execute a `program_path` from disk."
  def exe(program_path) do
    if Wizard.valid_path?(program_path) && File.exists?(program_path) do
      item = case Path.extname(program_path) do
        ".exs"  -> Code.eval_file program_path
        ".doh"  -> File.read!     program_path
      end
      program = %Program{
        unique: ILM.Castle.uuid,
          code: item
      }
    end
    
    program
  end
  
end


