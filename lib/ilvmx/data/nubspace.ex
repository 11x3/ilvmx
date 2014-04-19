defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Cupcake
  alias ConCache

  @nubspace :nubspace
  
  # Public
  
  @doc """
  Put `cupcake` into `nubspace`.
  """
  def push!(nubspace, cupcake) do
    nub = get nubspace
    nub = nub.cupcakes(Enum.concat(nub.cupcakes, [cupcake]))
        
    # todo: explore nub storage options 
    ConCache.put ILM.cache, @nubspace, Dict.put(cupcakes, nubspace, nub)
        
    # unique / key / value
    ILM.TowerServer.signal! nubspace, Event.w(nub.unique, nub)

    nub
  end
  
  @doc """
  Get a nub from the Castle.
  """
  def pull!(nubspace) when is_binary nubspace do
    get nubspace    
  end


  # Private

  @doc """
  Return all `cupcakes` in the Castle.
  """
  def cupcakes do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end
  
  # Pull `nubspace` from cache or Db
  defp get(nubspace) when is_binary nubspace do
    Dict.get cupcakes, hash(nubspace), Nub.w(nubspace)
  end
  
  defp cupcake(n = Nub[]) do
    "##{ n.galaxy } ##{ n.castle } ##{ n.system } ##{ n.domain } ##{ n.module } ##{ n.member } ##{ n.method } "
  end
  
  defp hash(cupcake) do
    cupcake
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end