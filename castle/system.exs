"lolnub"
|> Castle.Game.on! Program.cmd(fn -> IO.inspect "Castle.Game.on! lolnub" end)
|> Castle.beam!(Signal.m Program.cmd fn -> "welcome.." end)








## Setup

# @doc "A generic welcome message for all Players."
# "players/hello" |> Castle.beam! Program.cmd fn -> "(x-x-) #hello" end
#
# @doc "List all Castle.Nubspace.signals."
# "signals/list"  |> Castle.beam! Program.cmd fn -> Castle.signals end








# Castle.ping! Program.app "details", fn signal ->
#   Signal.a signal, "#todo: breakdown details of the signal request"
# end