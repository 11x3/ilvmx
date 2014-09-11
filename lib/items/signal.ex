defmodule Signal do
  defstruct      set: nil,  # "about/ilvmx"
                item: nil,  # request/item/upload/etc
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil,  # uuid
               owner: nil   # Player
   
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.  
  """
  
  # Signal.set about: Bot.pull "html/about"
  
  @doc "Make a `Signal`."
  def m(set \\ Castle.name, thing \\ nil, source \\ nil) do
    %Signal{
           set: set,
          item: thing,
         items: [],
        source: source,
        unique: Castle.uuid,
         owner: Player.anon!
    }
  end

  ## Instance
  
  @doc "Add `items` to `signal`."
  def boost(signal, items) do
    %{signal| items: List.flatten([signal.items|[items]]) }
  end

end

