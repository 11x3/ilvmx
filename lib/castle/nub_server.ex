use Jazz

defmodule ILVMX.Nub.Server do
  use GenServer
  
  @metanub "meta"
  
  ## Public
  
  @doc """
  Put `item` into `nubspace`.
  """
  def push!(nubspace, item) when is_list(nubspace) and is_binary(item) do
    nubspace |> Enum.each |> push! item
  end
  def push!(nubspace, item) when is_binary(nubspace) and is_function(item) do
    #todo: store to the function to our local cache
    
    throw IO.inspect "push!(nubspace, item) is_function(item)"
  end
  def push!(nubspace, item) when is_binary(nubspace) and is_binary(item) do
    # create nub + meta directory
    nub = nub_path(nubspace)
    unless File.exists? nub do
      File.mkdir! nub
    end
    
    # check/create the metanub
    meta = meta_path(nubspace)
    unless File.exists? meta do
      File.write!(meta, JSON.encode!([]))
    end
    
    # set the static item into the nub
    file = Path.join(nub, "#{ ILVMX.Castle.Server.uuid }")
    File.write(file, item)
    
    # update our nubspace meta file to add the link to the new item
    items = JSON.decode!(File.read!(meta))
    json  = JSON.encode!([items, %{item: file}], keys: :atoms)
    File.write!(meta, json)
        
    ILVMX.Castle.Tower.Server.signal! Effect.w nubspace, [item: item, static: file]
  end
  
  @doc """
  Get a `nubspace` (meta file) from the local Castle.
  """
  def pull!(nubspace) when is_binary(nubspace) do
    # create nub + meta directory
    unless File.exists? nub_path(nubspace) do
      Effect.w nubspace, "404"
    else
      Effect.w nubspace, File.read!(meta_path(nubspace))
    end
  end
  def pull!(nubspace, item_id) when is_binary(nubspace) do
    #todo: grab the item specifically from the nubspace
    
    throw IO.inspect "pull!(nubspace, item_id)"
  end
  
  ## Private
  
  def nub_path(nubspace),  do: Path.join("priv/static/api/obj", String.lstrip(nubspace, ?#))
  def meta_path(nubspace), do: Path.join("priv/static/api/nub", String.lstrip(nubspace, ?#))
  
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end