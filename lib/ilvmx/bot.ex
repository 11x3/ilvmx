use Jazz

defmodule Bot do
  @moduledoc """
  Bots are the direct-level workers of the ILvMx universe,
  and are the foundation of the Cakedown (or whatever it 
  eventually becomes called) markup syntax.
  """

  ## World API (readin the webs)

  @doc "Read a file from the internet."
  def web(path) do
    if ILM.Castle.Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Nubspace API (nubspace = cooking with love)
  
  @doc "Put `item` into `nubspace`."
  def push(nubspace, item = %Item{}) when is_binary(nubspace) do
    # defmodule Item do
    #   defstruct   kind: nil,  # String (eg. mime/type)
    #             unique: nil,  # "32453-4544-3434-234324-7879"
    #               path: nil,  # %{}           => "obj/32453-4544-3434-234324-7879"
    #               meta: nil   # :ilvmx        => "obj/32453-4544-3434-234324-7879/meta"
    #            content: nil,  # {:file, etc}  => "bin/32453-4544-3434-234324-7879/content"
    
    # set the item into nubspace
    
    # create nub directory
    nub_path = Path.join("priv/static", nub_path(nubspace))
    unless File.exists? nub_path do
      File.mkdir! nub_path
    end
    
    # check/create the metanub
    meta_path = Path.join(nub_path, "meta")
    unless File.exists? meta_path do
      File.write!(meta_path, JSON.encode!([item.path]))
    end
    
    # update our nubspace meta file to add the link to the new item
    items = JSON.decode! File.read!(meta_path)
    items = [item.path|items]
    
    # write the meta file
    File.write!(meta_path, JSON.encode!(items))

    # add the ln
    #File.ln_s(item.path, Path.join(nub_path, item.path)) 
    
    # todo: add the nubspace link to item.meta
    # Bot.set item, :links, nubspace
    
    item
  end
  def push(nubspace, data, binary \\ nil) when is_binary(nubspace) and is_binary(data) do
    push nubspace, Bot.set(data, binary)
  end
  
  @doc "List `nubspace` items."
  def pull(nubspace) when is_binary(nubspace) do
    # todo: IT.valid_path?(nubspace)

    # check
    nubspace  = Path.join("priv/static", nub_path(nubspace))
    meta_path = Path.join(nubspace, "meta")

    unless ILM.Castle.Wizard.valid_path?(nubspace) and File.exists?(meta_path) do
      # todo: return an error
      []
    else
      JSON.decode! File.read!(meta_path)
    end
  end


  ## Item API (items are at the kinda slightly structured level)
  
  def set(data, binary \\ nil) do
    item = Item.m data, binary
    Bot.make inspect(item), item.path
    if binary do
      Bot.make binary, "#{item.path}.bin"
    end
    item
  end
  
  def get(obj_paths) when is_list(obj_paths) do
    obj_paths |> Enum.map fn path ->
      get(path)
    end
  end
  def get(obj_path) do
    # read and eval the item data into an Item
    data = take(obj_path)
    {item, _binding} = Code.eval_string data
    
    item
  end
  
  
  ## File API (file system level blobs)
  
  @doc "Take files from priv/static."
  def take(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless ILM.Castle.Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end

  @doc "Place objects into The World, oh our dear World."
  def make(data, static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless ILM.Castle.Wizard.valid_path?(prop_path) do
      nil
    else
      File.write!(prop_path, data)
      
      data
    end
  end
  
  
  ## Private
  
  defp nub_path(nubspace) do
    # todo: secure nubspace
    Path.join("nub", String.lstrip(nubspace, ?#))
  end
  
end