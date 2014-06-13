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
    File.write!(meta, JSON.encode!(
      List.flatten([items|["item", file]]
    )))
    
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
  
  ## Private
  
  def nub_path(nubspace),  do: Path.join("priv/static/obj", String.lstrip(nubspace, ?#))
  def meta_path(nubspace), do: nubspace |> nub_path |> Path.join @metanub
  
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end