use Jazz

defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
                 let: nil,  # request/item/upload/etc
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil,  # uuid
               owner: nil   # Player
  
               
               
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.  
  """
  
  # Signal.set about: Bot.pull "html/about"
  
  @doc "Make a `Signal`."
  def m(path \\ Castle.name, item \\ nil, source \\ nil) do
    %Signal{
          path: path,
           let: item,
         items: [],
        source: source,
        unique: Castle.uuid,
         owner: Player.anon!
    }
  end

  ## Instance
  
  @doc "Add `items` to `signal`."
  def boost!(signal, items) when is_list(items) do
    %{signal| items: List.flatten([signal.items|items]) }
  end
  def boost!(signal, item) do
    %{signal| items: List.flatten([signal.items|[item]]) }
  end


  ## Private
  
  defp nub_path(nubspace) do
    # todo: secure nubspace
    Path.join("nub", String.lstrip(nubspace, ?#))
  end
  
end

