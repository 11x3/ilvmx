IO.inspect "./system.exs"

Castle.beam! Signal.m "hello", Program.exe fn s ->
  Item.m "how are you?"
end

#
# Castle.beam! , Program.exe fn signal ->
#   signal = signal
#   |> Castle.CPU.execute!
#   |> Castle.Wizard.filter?
#
#   Castle.next? signal
#
#   signal
# end
#
#



# Signal.m "system", Program.cmd fn ->
#   Item.m IO.inspect "system.exs: #{ self }"
# end |> Castle.beam!
#




#|> Castle.Game.host! Program.cmd(fn -> IO.inspect "Castle.Game.host!" end)






## Setup

# @doc "A generic welcome message for all Players."
# "players/hello" |> Castle.beam! Program.cmd fn -> "(x-x-) #hello" end
#
# @doc "List all Castle.Nubspace.signals."
# "signals/list"  |> Castle.beam! Program.cmd fn -> Castle.signals end








# Castle.ping! Program.app "details", fn signal ->
#   Signal.a signal, "#todo: breakdown details of the signal request"
# end