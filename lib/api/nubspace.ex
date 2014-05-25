defmodule Nubspace do
  use GenServer.Behaviour

  @nubspace :nubspace
  
  
  # Public
    
  @doc """
  Get a `nubspace` from the local Castle.
  """
  def pull!(nubspace) when is_binary(nubspace) do
    nub = Dict.get effects, hash(nubspace), Nub.w(nubspace)
    
    # unique / key / value
    ILM.Castle.Tower.signal! Event.w(nub.unique, nub), nubspace
    
    nub
  end

  @doc """
  Put `program` into `nubspace`.
  """
  def push!(nubspace, prop) when is_binary(nubspace) and is_binary(prop) do
    # get the nub
    nub = pull! nubspace
    
    # add the new source
    nub = %{ nub | effects: Enum.concat(nub.effects, [prop]) }
    
    # store the new nub
    ConCache.put ILM.cache, @nubspace, Dict.put(effects, hash(nubspace), nub)
    
    # signal on   unique / key / value
    ILM.Castle.Tower.signal! Event.w(nub.unique, nub), nubspace

    nub
  end
  
  
  # Private

  @doc """
  Return all `effects` in the Castle.
  """
  defp effects do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end

  @doc """
  # todo: :crypto.sha1 or otherwise hash the nubspace
  """
  defp hash(nubspace) do
    nubspace
  end
  
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end