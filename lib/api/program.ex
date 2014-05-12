defmodule Program do
defstruct    setup: %{},
              code: [],
              data: %{},
            unique: nil

  # 
  # get "example"
  # set "@example args"
  # exe "#example args"
  # jmp "!example #results"
  # pip "#results |> #take 5"

  # Program.cmds do
  #   !me @jams
  #   !me !profile @friends jeff
  #   #lolnub #players #ping
  #   #ilm #filters #after #exitpoll @me
  #   #signals #players @me
  #   #ilm #signals #players #filter #latest @me
  # end

  #@me @debug fn p -> IO.inspect p end

  # @cap #ilm #signals #players @do
  # | @elm "5x5", "/elm/app"
  # | @set :title, "Welcome to lolnub!"       
  # | @cap ["#apps #chat"]           # @ picture in place, or unquote
  # | @pip ["#apps #friends"]
  # | @pip ["#web #youtube |> #search", "a7x"]
  # | @nub ["#apps #footer"]
  # @end
  
  @doc """
  Compile commands into a program.
  """
  def cmp(commands) when is_list(commands) do
    # String.split(bot.program, "\n") |> Enum.map fn cmd ->
    #     # program = "@set #chat todo"
    #     cmd = String.slice(String.lstrip(bot.program), 0..3)
    #     [nub, pro] = String.split String.replace(bot.program, "#{ cmd } ", "")
    # 
    #     run(cmd, nub, pro)
    #   end
    # 
    #   Bot.effect bot, ILM.Nubspace.pull! bot.program
    # 
    #   nub = ILM.Nubspace.pull! nubspace
    # 
    #   results = nub.programs |> Enum.map fn pro ->
    #     case is_function pro do
    #       true  -> 
    #         try do
    #           Effect.w program: pro, result: pro.(bot.program)
    #         rescue 
    #           x in [RuntimeError, ArgumentError, BadArityError] -> 
    #             Effect.w error: x, program: pro
    #         end
    #       false -> [pro]
    #     end
    #   end
    # 
    #   bot = %{ bot | results: List.flatten(Enum.concat(bot.results, results)) }
    # end
  end
  
  def run(bot) do
    bot
  end
  def run(bot, program) do
    bot
  end
  def run(bot, "@set", arg) do
    Bot.effect bot, "ignore: setup(program, @set, unsupported)"
  end
  def run(bot, "@app", nubspace) do
    Bot.effect bot, "ignore: setup(program, @set, unsupported)"
  end
  def run(bot, "@fps", fps) do
    Bot.effect bot, "ignore: setup(program, @set, unsupported)"
  end
  def run(bot, "@tmp", arg) do
    Bot.effect bot, "ignore: setup(program, @set, unsupported)"
  end
  def run(bot, "@exe", arg) do
    Bot.effect bot, "ignore: setup(program, @exe, unsupported)"
  end
  def run(bot, "@cap", arg) do
    Bot.effect bot, "ignore: setup(program, @cap, unsupported)"
  end
  def run(bot, "@pip", arg) do
    Bot.effect bot, "ignore: setup(program, @pip, unsupported)"
  end
  def run(bot, "@sig", arg) do
    Bot.effect bot, "ignore: setup(program, @sig, unsupported)"
  end
  def run(bot, "@mix", arg) do
    Bot.effect bot, "ignore: setup(program, @mix, unsupported)"
  end
  def run(bot, "@elm", arg) do
   Bot.effect bot, "ignore: setup(program, @elm, unsupported)"
  end
end