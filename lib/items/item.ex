defmodule Item do
  defstruct   kind: nil,  # [:data, :program] (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
           content: nil,  # {:file, etc}  => "obj/32453-4544-3434-234324-7879/binary"
              meta: nil   # :ilvmx        => "obj/32453-4544-3434-234324-7879/meta"
            
  
  @moduledoc """
  Items are the simplest objects in the Kingdom.
  #todo: partition the disk on Item.unique
  """
  def m(content \\ nil) do
    # an empty item
    m(nil, content)
  end
  def m(kind, content) do
    unique = Castle.uuid
    item = %Item{
      unique: unique,
     content: content,
        kind: kind,
        meta: %{}
    }
  end
  
  def path(item = %Item{}) do
    "obj/#{ item.unique }"
  end

end
