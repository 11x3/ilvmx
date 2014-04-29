defmodule ILM.Castle.Dungeon do
  use GenServer.Behaviour
  
  @doc """
  *Shh...*
  """
  def execute!(bot) do
    execute! bot, bot.nubcake
  end
  def execute!(bot, nubcake) when is_function(nubcake) do
    # dispatch for the pull shortcut
    try do
      bot.nubcake().()
    rescue 
      x in [RuntimeError, ArgumentError, BadArityError] -> 
        Bot.effect bot, Effect.w error: x
    end
  end
  def execute!(bot, nubcake) when is_binary(nubcake) do
    # get the first character of the nubcake
    hint = String.slice(nubcake, 0..0)
    
    case hint do
      "#"   -> Bot.effect bot, ILM.Nubspace.pull! nubcake
      "@"   -> String.split(bot.nubcake, "\n") |> Enum.map fn cmd ->
        # nubcake = "@set #chat todo"
        cmd = String.slice(String.lstrip(nubcake), 0..3)
        [nub, opt] = String.split String.replace(nubcake, "#{ cmd } ", "")

        execute!(cmd, nub, opt)
      end
    end
  end
  def execute!(cmd, nub, opt) when is_binary(cmd) do
    case cmd do
      "@set" -> Bot.set nub, opt
    end
  end
  def execute!(bot, nubcake, nubspace) do
    nub = ILM.Nubspace.pull! nubspace
    
    results = nub.nubcakes |> Enum.map fn cake ->
      case is_function cake do
        true  -> 
          try do
            Effect.w nubcake: cake, result: cake.(bot.nubcake)
          rescue 
            x in [RuntimeError, ArgumentError, BadArityError] -> 
              Effect.w error: x, nubcake: cake
          end
        false -> [cake]
      end
    end

    bot = %{ bot | results: List.flatten(Enum.concat(bot.results, results)) }
  end


  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end