defmodule ILM.Nubspace do
  use GenServer.Behaviour
  use OtpDsl.Genserver

  # todo: :crypto.sha1 the nubspace
  
  alias ConCache

  @subspace :subspace


  @doc """
  Return all Nubs in the Castle. (won't be here long)
  """
  def nubs(:list) do
    Dict.get(nubs, :list) |> Dict.to_list 
  end
  def nubs(:tree) do
    Dict.get(nubs, :tree)
  end
  def nubs do
    n = ConCache.get_or_store ILM.cache, @subspace, fn -> 
      HashDict.new(
        tree: HashDict.new,
        list: [
          method: [],
          galaxy:  [],
          castle: [],
          system: [],
          domain: [],
          module: [],
          member: []
        ])
    end
  end
  
  @doc """
  Put a nub into the Castle.
  """
  def put(nub) do
    nub |> place_nub
  end
  
  @doc """
  Get a nub from the Castle.
  """
  def get(nubspace) when is_binary nubspace do
    Dict.get(nubs(:tree), nubspace, Nub.w)
  end
  def get(nub) when not nil? nub do
    get hash(nub)
  end
  
  # Private
  defp place_nub(nub) do
    # Nub[
    #   method: :ilm,   # [:ilm, :http]
    #    galaxy: nil,    # :network
    #   castle: nil,    # [:server, :cluster, :etc]
    #   system: nil,    # :api  # system
    #   domain: nil,    # :api  # subsys
    #   module: nil,    # :api  # module
    #   member: nil,    # :api  # function
    #   bucket: []   do # :data # args
    # ]
    
    # todo: explore nub storage options 
    sub  = nubs
    tree = nubs[:tree]
    tree = Dict.put(tree, hash(nub), nub)
    sub  = Dict.put(sub,  :tree, tree)
    
    ConCache.put ILM.cache, @subspace, sub
    
    nub
  end
  
  defp hash(n = Nub[]) do
    "##{ n.method } ##{ n.galaxy } ##{  n.castle } ##{ n.system } ##{ n.domain } ##{ n.module } ##{ n.member }"
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end