defmodule ILM.Castle.Dungeon do
  use GenServer.Behaviour
  
  @doc """
  *Shh...*
  """
  def execute!(bot) do
    execute! bot, bot.program
  end
  def execute!(bot, program) when is_function(program) do
    # dispatch for the pull shortcut
    try do
      bot.program().()
    rescue 
      x in [RuntimeError, ArgumentError, BadArityError] -> 
        Bot.effect bot, Effect.w error: x
    end
  end
  def execute!(bot, program) when is_binary(program) do
    # get the first character of the program
    hint = String.slice(program, 0..0)
    
    case hint do
      "#"   -> Bot.effect bot, ILM.Nubspace.pull! program
      "@"   -> String.split(bot.program, "\n") |> Enum.map fn cmd ->
        # program = "@set #chat todo"
        cmd = String.slice(String.lstrip(program), 0..3)
        [nub, pro] = String.split String.replace(program, "#{ cmd } ", "")

        execute!(cmd, nub, pro)
      end
    end
  end
  def execute!(cmd, nub, pro) when is_binary(cmd) do
    case cmd do
      "@set" -> Bot.set nub, pro
    end
  end
  def execute!(bot, program, nubspace) do
    nub = ILM.Nubspace.pull! nubspace
    
    results = nub.programs |> Enum.map fn pro ->
      case is_function pro do
        true  -> 
          try do
            Effect.w program: pro, result: pro.(bot.program)
          rescue 
            x in [RuntimeError, ArgumentError, BadArityError] -> 
              Effect.w error: x, program: pro
          end
        false -> [pro]
      end
    end

    bot = %{ bot | results: List.flatten(Enum.concat(bot.results, results)) }
  end


  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end