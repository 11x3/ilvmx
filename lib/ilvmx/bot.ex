use Jazz

defmodule Bot do
  @moduledoc """
  Bots are direct-level workers of the ILvMx universe.
  
  Bots are the foundation of the Cakedown (or whatever it 
  
  eventually becomes called) markup syntax.
  
  All public `Bot` functions work with user generated content,
  and so should be hostile safe. #todo
  """

  ## World API (readin the webs)

  @doc "Read a file from the internet."
  def web(path) do
    if Castle.Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Nubspace API (nubspace = cooking with love)
  
  @doc "Put `item` into `nubspace`."
  def push(nubspace, data) when is_binary(nubspace) and is_binary(data) do
    push nubspace, Item.m(data)
  end
  def push(nubspace, item = %Item{}) when is_binary(nubspace) do
    # set the item into nubspace
    Bot.make(inspect(item), Item.path(item))
    
    # create nub directory
    nub_path = Path.join("priv/static", nub_path(nubspace))
    unless File.exists? nub_path do
      File.mkdir_p! nub_path
    end
    
    # check/create the metanub
    meta_path = Path.join(nub_path, "meta")
    unless File.exists? meta_path do
      File.write!(meta_path, JSON.encode!([]))
    end
    
    # update our nubspace meta file to add the link to the new item
    items = JSON.decode! File.read!(meta_path)
    items = [Item.path(item)|items]
    
    # write the meta file
    File.write!(meta_path, JSON.encode!(items))

    # add the ln
    File.ln_s(Item.path(item), Path.join(nub_path, Item.path(item)))
    
    #todo: return an ownership token
    
    item
  end
  
  @doc "Return a list of `nubspace` items."
  def pull(nubspace) when is_list(nubspace) do
    pull Path.join(nubspace)
  end
  def pull(nubspace) when is_binary(nubspace) do
    # check
    nubspace  = Path.join("priv/static", nub_path(nubspace))
    meta_path = Path.join(nubspace, "meta")

    unless Castle.Wizard.valid_path?(nubspace) and File.exists?(meta_path) do
      # todo: return an error
      []
    else
      JSON.decode!(File.read!(meta_path))
    end
  end


  ## Item API (items are at the kinda slightly structured level)
  
  @doc "Return an `Item` set with `data` as the content"
  def set(data) do
    item      = Item.m data
    item_path = Item.path item 
    
    unless File.exists? item_path do
      File.mkdir_p! item_path
    end
    
    Bot.make inspect(item), Item.path(item)
    
    item
  end
  
  def get(obj_paths) when is_list(obj_paths) do
    obj_paths |> Enum.map fn path ->
      get(path)
    end
  end
  def get(obj_path) do
    # read and eval the item data into an Item    
    {item, _binding} = Code.eval_string(take(obj_path))
        
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
  
  
  ## Private
  
  defp nub_path(nubspace) do
    # todo: secure nubspace
    Path.join("nub", String.lstrip(nubspace, ?#))
  end
  
end