require Logger

Logger.debug "./system.exs"

"hi" |> Signal.m(Program.cmd fn s -> 
    Bot.new Markdown.to_html """
    HAHAHAHAAHA!!! #{inspect s.unique}
    
    #welcome
    
    Hi from the server.
    """
  end) |> Castle.beam!

"castle/source" |> Signal.m(Program.cmd fn s -> 
    Logger.debug "system.exs: #{ self }" 
  end) |> Castle.beam!

"castle/signals" |> Signal.m(Program.cmd fn s -> 
    Bot.new Castle.signals 
  end) |> Castle.beam!
