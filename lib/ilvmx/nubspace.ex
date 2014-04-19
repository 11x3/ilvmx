defmodule ILM.Nubspace do
  use GenServer.Behaviour

  # todo: :crypto.sha1 the nubspace
  alias Cupcake
  alias ConCache

  @nubspace :nubspace

  @doc """
  Return all `cupcakes` in the Castle.
  """
  def cupcakes do
    n = ConCache.get_or_store ILM.cache, @nubspace, fn -> 
      HashDict.new
    end
  end
  
  
  @doc """
  Put `cupcake` into `nubspace`.
  """
  def push!(nubspace, cupcake) do
    nub = get nubspace
    nub = nub.cupcakes(Enum.concat(nub.cupcakes, [cupcake]))
        
    # todo: explore nub storage options 
    ConCache.put ILM.cache, @nubspace, Dict.put(cupcakes, nubspace, nub)
        
    # unique / key / value
    ILM.EmitServer.signal! nubspace, Event.w(nub.unique, nub)

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
        true  -> 
          try do
            Effect.w cupcake: cake, result: cake.(bot.cupcake)
          rescue 
            x in [RuntimeError, ArgumentError, BadArityError] -> 
              Effect.w error: x, cupcake: cake
          end
        false -> [cake]
      end
    end
    
    bot.results(List.flatten(Enum.concat(bot.results, results)))
  end
  
  @doc """
  Dispatch or call the Bot + Nub pair.
  """
  def upload!(bot = Bot[]) do
    # grab the nub from midair..
    nub = ILM.Nubspace.pull! bot.nubspace

    # are we a function?
    case is_function bot.cupcake do
      true  -> bot.cupcake.([bot: bot, nub: nub])
      false -> nub
    end
  end
  
  
  # Private
  
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