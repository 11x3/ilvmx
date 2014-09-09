defmodule GameTest do
  alias Castle.Game
  use ExUnit.Case, async: true
  
  ## Game
  
  # @doc "Publish a `Signal` to the Game rules."
#   def on!(signal, program = %Program{}) do
#     #todo: broadcast to ruleset
#     signal
#     |> Castle.beam!
#   end
#
#   @doc "#todo: Send a command to the arcade."
#   def on?(signal, command \\ nil, item \\ nil) do
#     Player.items Player.start, Castle.ping!(Signal.m(command, item))
#   end
#
  # test "Game.on?",
  #   do: assert %Signal{} == Castle.Game.host!("lol", Program.cmd(fn -> IO.inspect "lol" end))


  test "Game.next?", 
    do: assert %Signal{} = Game.next? Signal.m
    
  test "Game.ping!",
    do: assert %Signal{} = Game.ping! Signal.m
  
  
  test "Game.pipe!",
    do: assert %Signal{} = Game.pipe! Signal.m
  
  
  test "Game.archive!",
    do: assert %Signal{} = Game.archive! Signal.m

  
  test "Game.galaxy!",
    do: assert %Signal{} = Game.galaxy! Signal.m

end