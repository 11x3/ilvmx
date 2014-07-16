defmodule Bot do
  @moduledoc """
  Bots are the direct-level workers of the ILvMx universe,
  and are the foundation of the Cakedown (or whatever it 
  eventually becomes called) syntax.
  
  iex> Cake.down \"@list lolnub\"
  """
  
  ## World API (readin the webs)

  @doc "Read a file from the internet."
  def web(path) do
    if Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Nubspace API (nubspace = cooking with love)
  def list do
    []
  end
  def list(nubspace) do
    # check    
    
    nubspace = Path.join("priv/static", nub_path(nubspace))

    unless Wizard.valid_path?(nubspace) do
      list
    else
      nubmeta_path = "#{ nubspace }.meta"

      case File.exists?(nubmeta_path) do
       false  -> list
       true   ->
         case File.dir?(nubspace) do
           false  -> JSON.decode! File.read!("#{ nubspace }.meta")
           true   -> File.ls!(nubspace)
         end
      end
    end
  end
  
  @doc "Put `item` into `nubspace`."
  # def push(nubspace, item) when is_binary(nubspace) and is_function(item) do
  #   #todo: store to the function to our local cache
  #   throw IO.inspect "push!(nubspace, item) is_function(item)"
  # end
  def push(nubspace, item) when is_binary(nubspace) and is_binary(item) do
    # create nub directory
    nub_path = Path.join("priv/static", nub_path(nubspace))
    unless File.exists? nub_path do
      File.mkdir! nub_path
    end

    # set the static item into the nub
    sub_id = "#{ ILM.Castle.Server.uuid }"

    sub_path = Path.join(nub_path(nubspace), sub_id)
    file_path = Path.join("priv/static", sub_path)
    File.write(file_path, item)

    # check/create the metanub
    meta_path = Path.join(nub_path, "meta")
    if File.exists? meta_path do
      # update our nubspace meta file to add the link to the new item
      items = JSON.decode!(File.read!(meta_path))
      items = [sub_path|items]
      json  = JSON.encode!(items)

      File.write!(meta_path, json)
    else
      File.write!(meta_path, JSON.encode!([sub_path]))
    end
  end

  @doc "Get a `nubspace` (meta file) from the local Castle."
  def pull(nubspace) when is_binary(nubspace) do
    # todo: IT.valid_path?(nubspace)
    # create nub + meta directory
    if File.exists? Path.join("priv/static", nub_path(nubspace)) do
      #File.read!(Path.join("priv/static", "#{ nub_path(nubspace) }/meta"))
    end
  end
  
  
  ## Item API (items are at the kinda slightly structured level)

  def item(binary \\ nil) do
    item = Item.m binary
    
    Bot.make inspect(item), item.path
    
    item
  end
  
  def get(item, key) do
    
  end
  
  def set(item, key, value) do
    #Bot.make Dict.update(object(item), key, value), item.object
  end
  
  
  ## File API (file system level blobs)
  
  @doc "Take files from priv/static."
  def take(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end

  @doc "Place objects into The World, oh our dear World."
  def make(data, static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) do
      nil
    else
      File.write!(prop_path, data)
      
      data
    end
  end
  
  
  ## Private
  
  def nub_path(nubspace) do
    # todo: secure nubspace
    Path.join("nub", String.lstrip(nubspace, ?#))
  end
  
end