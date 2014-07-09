defmodule Program do
  defstruct source: nil,  # Item
              code: [],   # [terms]
              data: %{},  # storage
            errors: [],   # exceptions or manual logged errors
            unique: nil
            
  @doc """
  Execute a `program_path` from disk.
  """
  def setup(program_path) do
    case Path.extname(program_path) do
      ".cake" -> cake(program_path)
    end
  end
  
  @doc """
  Exe a Cakedown cloud app text document.
  """         
  def cake(program_path) do
    IO.inspect "Program.cake: #{ Path.basename(program_path) }"
    
    program = %Program{
      unique: ILM.Castle.uuid,
      source: File.read!(program_path)
    }

    program
  end

end


