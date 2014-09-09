IO.inspect "./system.exs"

"hello"
  |> Signal.m(Program.cmd fn s -> 
    Bot.new "HAHAHAHAAHA!!! #{inspect s.unique} see: system/"
  end) |> Castle.beam!
    
"system/source" |> Signal.m(Program.cmd fn s -> 
    IO.inspect "system.exs: #{ self }" 
  end) |> Castle.beam!

"system/signals/list" |> 
  Signal.m(Program.cmd fn s -> 
    Bot.new Castle.signals 
  end) |> Castle.beam!


# Castle.ping! Program.app "details", fn signal ->
#   Signal.a signal, "#todo: breakdown details of the signal request"
# end