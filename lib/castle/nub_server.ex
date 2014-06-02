use Jazz

defmodule ILVMX.Nub.Server do
  use GenServer.Behaviour
  
  @metanub "meta"
  
  # Public
  
  @doc """
  Put `item` into `nubspace`.
  """
  def push!(nubspace, item) when is_list(nubspace) and is_binary(item) do
    nubspace |> Enum.each |> push! item
  end
  def push!(nubspace, item) when is_binary(nubspace) and is_binary(item) do
    # create nub + meta directory
    nub = Path.join("priv/static/api", String.lstrip(nubspace, ?#))
    unless File.exists? nub do
      File.mkdir! nub
    end
    
    # check/create the metanub
    meta = Path.join(nub, @metanub)
    unless File.exists? meta do
      File.write!(meta, JSON.encode!([]))
    end
    
    # set the static item into the nub
    {:ok, count} = File.ls(nub)
    file = Path.join(nub, "#{ length(count) }")
    File.write(file, item)
    
    items = JSON.decode!(File.read!(meta))
  
    File.write!(meta, JSON.encode!(
      List.flatten([items|["item", file]]
    )))
    
    ILVMX.Castle.Tower.Server.signal! Effect.w nubspace, [item: item, static: file]
  end
  
  @doc """
  Get a `nubspace` from the local Castle.
  """
  def pull!(nubspace) when is_binary(nubspace) do
    # create nub + meta directory
    nub = Path.join("priv/static/api", String.lstrip(nubspace, ?#))
    unless File.exists? nub do
      Effect.w nubspace, "404"
    else
      meta = Path.join(nub, @metanub)
      Effect.w nubspace, JSON.decode!(File.read!(meta))
    end
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end