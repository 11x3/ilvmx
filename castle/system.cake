## install some html stubs
Signal.set("page/header", Bot.grab "header.html") |> Castle.install!
Signal.set("page/footer", Bot.grab "footer.html") |> Castle.install!


## basic commands

#``````
"hi" |> Signal.set(Program.cmd fn s -> 
    Item.w Markdown.to_html """
    #hi from the server... #{inspect s.unique}
    """
  end) |> Castle.install!

"signals" |> Signal.set(Program.cmd fn s -> 
    Item.w Castle.signal.items
  end) |> Castle.install!



## pages

"about" |> Signal.set(Program.cmd fn s -> 
    Item.w [Bot.pull("page/header"), Castle.signal.items, Castle.x]
  end) |> Castle.install!

"web" |> Signal.set(Program.cmd fn s ->
    Item.w Bot.web "http://lolnub.com"
  end) |> Castle.install!