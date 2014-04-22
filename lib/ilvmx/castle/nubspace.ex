defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Nubcake
  alias ConCache

  @nubspace :nubspace
  
  
  # Public
  
  @doc """
  Put `nubcake` into `nubspace`.
  """
  def push!(nubspace, nubcake) do
    nub = get nubspace
    nub = nub.nubcakes(Enum.concat(nub.nubcakes, [nubcake]))
        
    # todo: explore nub storage options 
    ConCache.put ILM.cache, @nubspace, Dict.put(nubcakes, nubspace, nub)
        
    # unique / key / value
    ILM.Tower.signal! nubspace, Event.w(nub.unique, nub)

    nub
  end
  
  @doc """
  Get a nub from the Castle.
  """
  def pull!(nubspace) when is_binary nubspace do
    nub = get nubspace
    
    # unique / key / value
    ILM.Tower.signal! nubspace, Event.w(nub.unique, nub)
    
    nub
  end


  # Private

  @doc """
  Return all `nubcakes` in the Castle.
  """
  def nubcakes do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end
  
  # Pull `nubspace` from cache or Db
  defp get(nubspace) when is_binary nubspace do
    Dict.get nubcakes, hash(nubspace), Nub.w(nubspace)
  end

  defp hash(nubcake) do
    nubcake
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end