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
#     Player.items Player.start, Castle.ping!(Castle.exe(command, item))
#   end
#
  # test "Game.on?",
  #   do: assert %Signal{} == Castle.Game.host!("lol", Program.cmd(fn -> Logger.debug "lol" end))

end