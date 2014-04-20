defmodule ILM.Castle.Dungeon do
  use GenServer.Behaviour
  
  @doc """
  *Shh...*
  """
  def execute!(bot = Bot[]) do
    execute! bot, bot.cupcake
  end
  def execute!(bot, cupcake) when is_function(cupcake) do
    # dispatch for the pull shortcut
    try do
      bot.cupcake().()
    rescue 
      x in [RuntimeError, ArgumentError, BadArityError] -> 
        Bot.effect bot, Effect.w error: x
    end
  end
  def execute!(bot, cupcake) when is_binary(cupcake) do
    # get the first character of the cupcake
    hint = String.slice(cupcake, 0..0)
    
    case hint do
      "#"   -> Bot.effect bot, ILM.Nubspace.pull! cupcake
      "@"   -> String.split(bot.cupcake, "\n") |> Enum.map fn cmd ->
        # cupcake = "@set #chat todo"
        cmd = String.slice(String.lstrip(cupcake), 0..3)
        [nub, opt] = String.split String.replace(cupcake, "#{ cmd } ", "")

        execute!(cmd, nub, opt)
      end
    end
  end
  def execute!(bot = Bot[], cupcake, nubspace) do
    nub = ILM.Nubspace.pull! nubspace
    
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
  def execute!(cmd, nub, opt) do
    case cmd do
      "@set" -> Bot.set nub, opt
    end
  end

  
  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end