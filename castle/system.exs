require Logger

Logger.debug "./system.exs"

"hello" |> Signal.m(Program.cmd fn s -> 
    Bot.new "HAHAHAHAAHA!!! #{inspect s.unique} see: system/"
  end) |> Castle.beam!
    
"castle/source" |> Signal.m(Program.cmd fn s -> 
    Logger.debug "system.exs: #{ self }" 
  end) |> Castle.beam!

"castle/signals" |> Signal.m(Program.cmd fn s -> 
    Bot.new Castle.signals 
  end) |> Castle.beam!
