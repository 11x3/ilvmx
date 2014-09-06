defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
                item: nil,  # data/params
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil,  # uuid
               owner: nil   # Player
  
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.
  """
  
  @doc "Make a `Signal`."
  def m(source, path \\ Castle.name, data \\ nil) do
    if data do
      item = Item.m data
    end
    
    %Signal{
          path: path,
          item: item,
         items: [],
        source: source,
        unique: Castle.uuid,
         owner: Player.anon!
    }
  end

  ## Instance
  
  @doc "Add `items` to `signal`."
  def a(signal, items) when is_list(items) do
    %{signal| items: List.flatten([signal.items|items]) }
  end
  def a(signal, item) do
    %{signal| items: List.flatten([signal.items|[item]]) }
  end
  
end

