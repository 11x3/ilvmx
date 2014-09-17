defmodule Item do
  defstruct object: nil,  # [:data, :program] (eg. mime/type)
            unique: nil,  # "32453-4544-3434-234324-7879"
           content: nil   # {:file, etc}  => "obj/32453-4544-3434-234324-7879/binary"
            
  @moduledoc """
  Items are the simplest objects in the Kingdom.
  #todo: partition the disk on Item.unique
  """
  def m(content \\ nil, object \\ nil) do
    unique = Castle.uuid
    item = %Item{
      unique: unique,
     content: content,
      object: object
    }
    
    # create static object
    Bot.make inspect(item), path(item)
    
    item
  end

  # @doc "Return existing `Item`s at `obj_path` which is looks like 'obj/UUID' etc."
  # def get(obj_paths) when is_list(obj_paths) do
  #   obj_paths |> Enum.map fn path ->
  #     get(path)
  #   end
  # end
  # def get(obj_path) do
  #   # read and eval the item data into an Item
  #   {item, _binding} = Code.eval_string(take(obj_path))
  #
  #   item
  # end
  
  def path(item = %Item{}) do
    "obj/#{ item.unique }"
  end

end
