defmodule Item do
  defstruct   kind: nil,  # String (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
            object: nil,  # %{} => "obj/32453/4544-3434-234324-7879/object"
            binary: nil,  # ""  => "bin/32453/4544-3434-234324-7879/binary"
            review: nil   #        "obj/32453/4544-3434-234324-7879/meta"
            

  @moduledoc """
  Items = JSON object + binary too.
  """
  def m do
    m(ILM.Castle.uuid)
  end
  def m(unique) do
    item = %Item{
      unique: unique,
      object: "obj/#{ unique }.json",
      binary: "bin/#{ unique }"
    }
  end
  
  # data/json type
  # binary type
  def object(item) do
    Bot.prop item.object
  end
  def object(item, object) when is_binary(object) do    
    Bot.drop object, item.object
    
    item
  end
  def object(item, object) do
    object item, inspect(object)
  end

  # binary type
  def binary(item) do
    Bot.prop item.binary
  end
  def binary(item, data) do
    Bot.drop data, item.binary

    item
  end
end
