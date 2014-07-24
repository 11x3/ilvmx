defmodule Item do
  defstruct   kind: nil,  # String (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
           content: nil,  # {:file, etc}  => "obj/32453-4544-3434-234324-7879/binary"
              meta: nil   # :ilvmx        => "obj/32453-4544-3434-234324-7879/meta"
            
  
  @moduledoc """
  Items are the simplest objects in the Kingdom.
  
  #todo: partition the disk on Item.unique
  """
  def m(content \\ nil) do
    unique = ILM.Castle.uuid
    item = %Item{
      unique: unique,
     content: content
    }
  end

  def path(item) do
    "obj/#{ item.unique }"
  end
  
end
