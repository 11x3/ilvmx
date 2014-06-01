defmodule ILVMX.Castle.CPU.Server do
  use GenServer.Behaviour
  
  @doc """
  *Shh...*
  
  # todo: add event to eventdrive
  """
  def schedule!(event) do
    
    event
  end

  # def execute!(event, program) when is_binary(program) do
  #   # get the first character of the program
  #   hint = String.slice(program, 0..0)
  #   
  #   # case hint do
  #   #   "#"   -> Bot.get(program)
  #   # end
  #   
  #   event
  # end
   
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
  
  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end