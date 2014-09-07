use Jazz

defmodule Bot do
  @moduledoc """
  Bots are direct-level workers of the ILvMx universe.
  
  Bots are the foundation of the Cakedown (or whatever it 
  eventually becomes called..) markup syntax.
  
  All public `Bot` functions work with user generated content,
  and so should be programmed as hostile safe. 
  
  Because Bots are stateless agents that work with side effects,
  they mostly revolve around a small set of concepts:
  
  Bot = [
    World,
    Castle.Nubspace,
    Item,
    File
  ]
  
  All processes should consider using Bots to interact with
  as primitives.
  """
  
  ## World API (readin the webs)

  @doc "Read a file from the internet."
  def web(path) do
    #todo: add a SpiderBot server and distribute these requests
    if Castle.Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Item/Nubspace API push/pull data+items (nubspace = cooking with love)
  
  @doc "Return a new `Item` set with `data` as the content"
  def new(data) do
    item = Item.m data
    Bot.make inspect(item), Item.path(item)
    
    item
  end
  
  
  ## File API (file system level blobs)

  @doc "Place objects into The World, oh our dear World."
  def make(data, static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    
    unless Castle.Wizard.valid_path?(prop_path) do
      nil
    else
      File.write!(prop_path, data)
      
      data
    end
  end
  
  @doc "Take files from priv/static."
  def take(static_relative_path_list) when is_list(static_relative_path_list) do
    (static_relative_path_list |> Enum.map &(take &1)) |> :binary.list_to_bin
  end
  def take(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Castle.Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end
    
end