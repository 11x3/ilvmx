defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Cupcake
  alias ConCache

  @nubspace :nubspace
  @signals  :signals

  @doc """
  Return all Nubs in the Castle.
  """
  def cupcakes do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end
  
  # @doc """
  # Return all Nubspace Signals in the Castle.
  # """
  # def signals do
  #   n = ConCache.get_or_store ILM.cache, @signals, fn -> 
  #     []
  #   end
  # end
  
  
  # @doc """
  # Call all captured signals.
  # """
  # def signal!(nubspace, cupcake) do
  # end

  @doc """
  Put .
  """
  def push!(nubspace, cupcake) do
    nub = get nubspace
    nub = nub.cupcakes(Enum.concat(nub.cupcakes, [cupcake]))
    
    # todo: explore nub storage options 
    ConCache.put ILM.cache, @nubspace, Dict.put(cupcakes, nubspace, nub)
    
    # push signals to update captures
    # signals |> Enum.filter fn sig ->
    #   cupcake == sig.cupcake
    # end |> Enum.to_list |> Enum.each fn sig ->
    #   if is_function sig.command do
    #     sig.command.(cupcake, contents)
    #   end
    # end
    
    nub
  end
  
  @doc """
  Get a nub from the Castle.
  """
  def pull!(nubspace) when is_binary nubspace do
    get nubspace
  end

  @doc """
  Execute a `nubspace` with `cupcake`.
  # todo: make this non-brute force
  """
  def jump!(bot, nubspace) do
    nub = pull! nubspace
    
    results = nub.cupcakes |> Enum.map fn cake ->
      case is_function cake do
        true  -> [cake.(bot, bot.cupcake)]
        false -> [cake]
      end
    end
    
    bot.results(List.flatten(Enum.concat(bot.results, results)))
  end
  

  @doc """
  Beam or lift a Bot (in a reactive style), onto a Nubspace to produce an 
  FRP-like signal. todo: add the :epoch support back in.
  
  Or.. beam a Bot up into the Nubspace where it may long live the rest of its 
  days. Or at least until it discovers a tiny civilization has developed on 
  the rear, and then God and friends save it. The End. 
  """
  # def beam!(bot) when not nil? bot do
  #   ConCache.put ILM.cache, @signals, Enum.concat(signals, [bot])
  #   
  #   bot
  # end
  
  # Private
  
  defp get(cupcake) when is_binary cupcake do
    Dict.get cupcakes, hash(cupcake), Nub.new(cupcake: cupcake)
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