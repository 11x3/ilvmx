use Jazz

defmodule ILM.Nub.Server do
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
    nub_path = Path.join("priv/static", nub_path(nubspace))
    unless File.exists? nub_path do
      File.mkdir! nub_path
    end

    # set the static item into the nub
    sub_id = "#{ ILM.Castle.uuid }"
    
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
          
    ILM.Castle.Tower.Server.signal! Effect.w nubspace, [item: item, static: sub_path]
  end
  
  @doc """
  Get a `nubspace` (meta file) from the local Castle.
  """
  def pull!(nubspace) when is_binary(nubspace) do
    # todo: IT.valid_path?(nubspace)
    # create nub + meta directory
    unless File.exists? Path.join("priv/static", nub_path(nubspace)) do
      Effect.w nubspace, "404"
    else
      Effect.w nubspace, File.read!(Path.join("priv/static", "#{ nub_path(nubspace) }/meta"))
    end
  end
  def pull!(nubspace, item_id) when is_binary(nubspace) do
    #todo: grab the item specifically from the nubspace
    throw IO.inspect "pull!(nubspace, item_id)"
  end
  
  ## Private
  
  def nub_path(nubspace),  do: Path.join("/obj", String.lstrip(nubspace, ?#))
    
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end