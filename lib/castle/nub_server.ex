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
    # create nub directory
    nub = nub_path(nubspace)
    unless File.exists? nub do
      File.mkdir! nub
    end

    # set the static item into the nub
    nub_id = "#{ ILVMX.Castle.Server.uuid }"
    
    file = Path.join(nub, nub_id)
    File.write(file, item)
    
    # check/create the metanub
    meta = Path.join(nub, ".meta")
    if File.exists? meta do
      # update our nubspace meta file to add the link to the new item
      items = JSON.decode!(File.read!(meta))
      items = [file|items]
      json  = JSON.encode!(items)
      File.write!(meta, json)
    else
      File.write!(meta, JSON.encode!([file]))
    end
          
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
      Effect.w nubspace, File.read!(Path.join(nub_path(nubspace), ".meta"))
    end
  end
  def pull!(nubspace, item_id) when is_binary(nubspace) do
    #todo: grab the item specifically from the nubspace
    
    throw IO.inspect "pull!(nubspace, item_id)"
  end
  
  ## Private
  
  def nub_path(nubspace),  do: Path.join("priv/static/api/obj", String.lstrip(nubspace, ?#))
  
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end