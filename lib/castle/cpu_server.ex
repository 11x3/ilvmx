defmodule ILM.Castle.CPU.Server do
  use GenServer
  
  @programs %{}

  @doc """
  Process a `Signal` and emit `Effect`s.
  """
  def process!(signal) do
    # defmodule Signal do
    #   defstruct     path: nil,
    #              content: nil,
    #               source: nil,
    #               unique: nil,
    #              effects: []

    # |> Enum.map fn item -> process!(signal, item) end
    # |> Signal.m
    
    # get all signal/programs
    
    signal
    |> ILM.Signal.Server.collect!
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Castle.Tower.Server.commit!
  end
  def process!(signal, item) do
    Effect.w item, item
  end
  
  ## GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end

  # try do
  #   event
  # rescue 
  #   x in [BadFunctionError, RuntimeError, ArgumentError, BadArityError] -> 
  #    #Effect.w error: x
  # end
  
  # "@"   -> String.split(bot.program, "\n") |> Enum.map fn cmd ->
  #   # program = "@set #chat todo"
  #   cmd = String.slice(String.lstrip(program), 0..3)
  #   [nub, opt] = String.split String.replace(program, "#{ cmd } ", "")
  # 
  #   execute!(cmd, nub, opt)

  # try do
  #   program.()
  # rescue 
  #   x in [RuntimeError, ArgumentError, BadArityError] -> 
  #     Effect.w error: x
  # end
  # 
  
  #   def execute!(cmd, nub, opt) when is_binary(cmd) do
  #     case cmd do
  #       "@set" -> Bot.set nub, opt
  #     end
  #   end
  #   def execute!(bot, program, nubspace) do
  #     nub = ILVMX.Nub.Server.pull!(nubspace)
  # 
  #     effects = nub.programs |> Enum.map fn cake ->
  #       case is_function cake do
  #         true  -> 
  #           try do
  #             Effect.w program: cake, result: cake.(bot.program)
  #           rescue 
  #             x in [RuntimeError, ArgumentError, BadArityError] -> 
  #               Effect.w error: x, program: cake
  #           end
  #         false -> [cake]
  #       end
  #     end
  # 
  #     bot = %{ bot | effects: List.flatten(Enum.concat(bot.effects, effects)) }
  #   end
