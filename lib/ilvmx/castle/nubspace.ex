defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Nubcake

  @nubspace :nubspace
  
  
  # Public
    
  @doc """
  Get a `nubspace` from the local Castle.
  """
  def pull!(nubspace) when is_binary nubspace do
    nub = Dict.get nubcakes, hash(nubspace), Nub.w(nubspace)
    
    # unique / key / value
    ILM.Tower.signal! nubspace, Event.w(nub.unique, nub)
    
    nub
  end

  @doc """
  Put `nubcake` into `nubspace`.
  """
  def push!(nubspace, nubcake \\ nil) do
    nub = pull! nubspace
    
    nub = %{ nub | nubcakes: Enum.concat(nub.nubcakes, [nubcake]) }
    
    # todo: explore nub storage options 
    Dict.put nubcakes, hash(nubspace), nub

    # unique / key / value
    ILM.Tower.signal! nubspace, Event.w(nub.unique, nub)

    nub
  end
  
  # Private

  @doc """
  Return all `nubcakes` in the Castle.
  """
  def nubcakes do
    HashDict.new
  end

  defp hash(nubcake) do
    nubcake
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end