defmodule Item do
  defstruct   kind: nil,  # String (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
              path: nil,  # %{}           => "obj/32453-4544-3434-234324-7879/object"
           content: nil,  # {:file, etc}  => "bin/32453-4544-3434-234324-7879/binary"
            review: nil   # :ilvmx        => "rev/32453-4544-3434-234324-7879/meta"
            
  
  @moduledoc """
  Items = JSON object + binary too.
  #todo: part out the :unique use
  """
  def m(content \\ nil, binary \\ nil) do
    unique = ILM.Castle.uuid
    item = %Item{
      unique: unique,
        path: "obj/#{ unique }",
     content: content
    }
    #todo: if binary is passed, write it with Bot.make
  end

end
