defmodule Item do
  defstruct object: nil,  # [:data, :program] (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
           content: nil   # {:file, <<whatever>>}
            
  @moduledoc """
  Item's are our legos and Nubspace is what we build with them.
  """
  
  @doc "Make and return an `item` with optional `content`."
  def w(content \\ nil) do
    unique = Castle.uuid
    item = %Item{
      unique: unique,
     content: content,
      object: %{}
    }
    
    # create static object
    Bot.make inspect(item), path(item)
    
    item
  end

  @doc "Update an existing `item` property `key` with `value`."
  def set(item = %Item{}, key, value \\ nil) when is_binary(key) do
    put_in item.object, Dict.put(item.object, key, value)
  end
  
  @doc "Return an existing `Item` at `item_unique` which looks something like 'obj/32453-4544-3434-234324-7879'."
  def get(item_unique) when is_binary(item_unique) do
    # read and eval the item data into an Item
    data = Bot.grab(Path.join "obj", item_unique)
    
    {item, _binding} = Code.eval_string data

    item
  end
  
  @doc "Return an existing `item`'s path or just use to hit test the unique."
  def path(item = %Item{}) do
    Path.join "obj", item.unique
  end
  def path(item_unique) when is_binary(item_unique) do
    Path.join "obj", item_unique
  end
   
end
