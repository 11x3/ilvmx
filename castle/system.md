"hi" |> Signal.m(Program.cmd fn s -> 
    Bot.new Markdown.to_html """
    HAHAHAHAAHA!!! #{inspect s.unique}
    
    #welcome
    
    Hi from the server.
    """
  end) |> Castle.beam!

"signals" |> Signal.m(Program.cmd fn s -> 
    Bot.new Castle.signal.items
  end) |> Castle.beam!
