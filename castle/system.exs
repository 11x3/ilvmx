IO.inspect "./system.exs"

"hello"
  |> Signal.m(Program.cmd fn s -> 
    Item.m "HAHAHAHAAHA!!! #{inspect s.unique} see: system/"
  end) |> Castle.beam!
    
"system/source" |> 
  Signal.m(Program.cmd fn s -> 
    Item.m IO.inspect "system.exs: #{ self }" 
  end) |> Castle.beam!

"system/signals/list" |> 
  Signal.m(Program.cmd fn s -> 
    Castle.signals 
  end) |> Castle.beam!


# Castle.ping! Program.app "details", fn signal ->
#   Signal.a signal, "#todo: breakdown details of the signal request"
# end