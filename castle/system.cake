## install some html stubs
Signal.set("page/header", Bot.take "header.html") |> Castle.install!
Signal.set("page/footer", Bot.take "footer.html") |> Castle.install!


## basic commands

#``````
"hi" |> Signal.set(Program.cmd fn s -> 
    Item.m Markdown.to_html """
    #hi from the server... #{inspect s.unique}
    """
  end) |> Castle.install!

"signals" |> Signal.set(Program.cmd fn s -> 
    Item.m Castle.signal.items
  end) |> Castle.install!



## pages

"about" |> Signal.set(Program.cmd fn s -> 
    Item.m [Bot.pull("page/header"), Castle.signal.items, Castle.x]
  end) |> Castle.install!

"web" |> Signal.set(Program.cmd fn s ->
    Item.m Bot.web "http://lolnub.com"
  end) |> Castle.install!