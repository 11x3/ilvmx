defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Cupcake
  alias ConCache

  @nubspace :nubspace
  @signals  :signals

  @doc """
  Return all Nubs in the Castle. (won't be here long)
  """
  def nubspace do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end
  
  @doc """
  Get a nub from the Castle.
  """
  def pull!(cupcake) when is_binary cupcake and not nil? cupcake do
    get cupcake
  end
  
  def push!(cupcake, contents) do
    nub = get cupcake
    nub = nub.bucket(Enum.concat(nub.bucket, [contents]))
    
    # todo: explore nub storage options 
    ConCache.put ILM.cache, @nubspace, Dict.put(nubspace, cupcake, nub)
    
    nub
  end
  
  # @doc """
  # Return all Nubs in the Castle. (won't be here long)
  # """
  # def signals do
  #   n = ConCache.get_or_store ILM.cache, @signals, fn -> 
  #     []
  #   end
  # end
  # 
  # @doc """
  # Beam or lift a Bot (in a reactive style), onto a Nubspace to produce an 
  # FRP-like signal. todo: add the :epoch support back in.
  # 
  # Or.. beam a Bot up into the Nubspace where it may long live the rest of its 
  # days. Or at least until it discovers a tiny civilization has developed on 
  # the rear, and then God and friends save it. The End. 
  # """
  # def capture!(bot) when not nil? bot do
  #   ConCache.put ILM.cache, @signals, Enum.concat(signals, [bot])
  #   
  #   throw IO.inspect bot
  #   throw IO.inspect signals
  #       
  #   bot
  # end


  
  # Private
  
  defp get(cupcake) when is_binary cupcake do
    Dict.get nubspace, hash(cupcake), Nub.from(cupcake)
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