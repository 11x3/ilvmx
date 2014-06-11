defmodule Program do
defstruct    setup: %{},
              code: [],
              data: %{},
            errors: [],
            player: nil,  
            unique: nil
  
  def run(event, program) do
    IO.inspect "@@@ program: #{ program }" 
  
    event
  end

end
