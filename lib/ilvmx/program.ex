defmodule Program do
  defstruct   code: nil,  # expression
              data: %{},  # storage
            errors: [],   # exceptions or manual logged errors
            unique: nil
  
  @doc "Execute a `program_path` from disk."
  def cmd(function) when is_function(function) do
    program = %Program{
      unique: ILM.Castle.uuid,
        code: function
    }
  end

  @doc """
  Exe a Cakedown cloud app text document.
  """   
  def doh(item = %Item{}) do
    program = %Program{
      unique: ILM.Castle.uuid,
        code: Item.object(item)
    }

    #todo: convert source into code

    program
  end
    
  @doc "Execute a `program_path` from disk."
  def bat(item = %Item{}) do
    program = %Program{
      unique: ILM.Castle.uuid,
        code: Item.binary(item)
    }
    
    # case Path.extname(item.) do
    #   ".exs"  -> Code.eval_file program_path
    #   ".doh" -> exe(program_path)
    # end
  end

end


