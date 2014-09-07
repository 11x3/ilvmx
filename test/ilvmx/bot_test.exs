defmodule BotTest do
  use ExUnit.Case, async: true
  
  ## File

  test "Bot.make to write files to disk", 
    do: assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  
  test "Bot.take to read files from disk", 
    do: assert Regex.match?(~r/html/, Bot.take(["header.html", "footer.html"]))
  
  
  ## Item

  test "Bot.new to create static items",
    do: assert File.exists? "priv/static/#{ Bot.new("chat") |> Item.path }"


  ## Nubspace
  
  test "Bot.push to link items in nubspace",
    do: assert "[\"#{to_string(Item.path(Bot.push("lol", "todo")))}\"]" == Bot.take("nub/lol/meta")
  

  ## World

  test "Bot.web to grab web pages", 
    do: IT.assert_web_page Bot.web(IT.web "/")


end