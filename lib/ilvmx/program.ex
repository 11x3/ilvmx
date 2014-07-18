defmodule Program do
  defstruct source: nil,
              code: nil,  # expression
              data: %{},  # storage
            errors: [],   # exceptions or manual logged errors
            unique: nil

  @moduledoc """
  Programming Program [wip][betabook]
  """
  
  ## Dynamic
  
  @doc "Exe raw Cakedown text."   
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
    
    #todo: quote the function

    program
  end
  
  
  ## Static
  
  @doc "Execute a `program_path` from disk."
  def exe(program_path) do
    if ILM.Castle.Wizard.valid_path?(program_path) && File.exists?(program_path) do
      program = %Program{
        unique: ILM.Castle.uuid,
        source: program_path,
          code: Item.m File.read!(program_path)
      }
    end
    
    program
  end
  
end


