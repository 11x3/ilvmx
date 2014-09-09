defmodule Item do
  defstruct   kind: nil,  # [:data, :program] (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
           content: nil   # {:file, etc}  => "obj/32453-4544-3434-234324-7879/binary"
            
  @moduledoc """
  Items are the simplest objects in the Kingdom.
  #todo: partition the disk on Item.unique
  """
  def m(content \\ nil) do
    unique = Castle.uuid
    %Item{
      unique: unique,
     content: content
    }
  end
  
  def path(item = %Item{}) do
    "obj/#{ item.unique }"
  end

end
