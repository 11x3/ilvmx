defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Program

  @nubspace :nubspace
  
  
  # Public
    
  @doc """
  Get a `nubspace` from the local Castle.
  """
  def pull!(nubspace) when is_binary nubspace do
    nub = Dict.get programs, hash(nubspace), Nub.w(nubspace)
    
    # unique / key / value
    ILM.Tower.signal! Event.w(nub.unique, nub), nubspace
    
    nub
  end

  @doc """
  Put `program` into `nubspace`.
  """
  def push!(nubspace, program \\ nil) do
    nub = pull! nubspace
    
    nub = %{ nub | programs: Enum.concat(nub.programs, [program]) }
    
    # todo: explore nub storage options
    ConCache.put ILM.cache, @nubspace, Dict.put(programs, hash(nubspace), nub)
    
    # unique / key / value
    ILM.Tower.signal! Event.w(nub.unique, nub), nubspace

    nub
  end
  
  
  # Private

  @doc """
  Return all `programs` in the Castle.
  """
  def programs do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end

  defp hash(nubspace) do
    nubspace
  end
  
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end