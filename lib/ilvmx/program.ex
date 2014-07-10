defmodule Program do
  defstruct source: nil,  # Item
              code: [],   # [terms]
              data: %{},  # storage
            errors: [],   # exceptions or manual logged errors
            unique: nil
  
  @doc """
  Make a `Program`.
  """
  def m(source, code \\ nil, data \\ nil) do
    %Program{
        source: source,
          code: code,
          data: data,
        unique: ILM.Castle.uuid
    }
  end
         
  @doc """
  Execute a `program_path` from disk.
  """
  def setup(program_path) do
    case Path.extname(program_path) do
      ".exs"  -> Code.eval_file program_path
      ".cake" -> cake(program_path)
    end
  end
  
  @doc """
  Exe a Cakedown cloud app text document.
  """         
  def cake(program_path) do    
    program = %Program{
      unique: ILM.Castle.uuid,
      source: File.read!(program_path)
    }

    program
  end

end


