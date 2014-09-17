defmodule BotTest do
  use ExUnit.Case, async: true
  
  ## File

  test "Bot.make to write files to disk", 
    do: assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  
  test "Bot.take to read files from disk", 
    do: assert Regex.match?(~r/html/, Bot.take(["header.html", "footer.html"]))
  
  
  ## World

  test "Bot.web to grab web pages", 
    do: IT.assert_web_page Bot.web(IT.web "/")


  ## Nubspace
      
  test "Bot.pull to grab web pages" do
    ILvMx.reset!
    Castle.install! Signal.set "lol", "nub"
    
    assert [] == Bot.pull "lol"
  end

end