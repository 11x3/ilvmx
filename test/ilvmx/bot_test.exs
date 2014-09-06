defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  ## World
    
  test "Bot.web to grab web pages" do
    IT.assert_web_page Bot.web(IT.web("/"))
  end


  ## Nubspace
  
  test "Bot.push to link items in nubspace" do
    assert %Item{} = Bot.push "chat", "todo"
  end

  test "Bot.pull to collect items from nubspace" do
    signal = Castle.sig "lolnub", "todo"
    
    assert (Bot.pull("lolnub") |> Enum.any? fn x -> x == "obj/#{ signal.item.unique }" end)
  end


  ## Item
  
  test "Bot.set to create static items" do
    assert %Item{content: "todo"} = Bot.set "todo"
  end
  
  test "Bot.get to init static items" do
    signal = Castle.sig "lolnub", "todo"
    
    assert Bot.pull(signal.path) |> Enum.map fn item_unique ->      
      assert %Item{} = Bot.get item_unique
    end
  end


  ## File

  test "Bot.make to write files to disk" do
    assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  end
  
  test "Bot.take to read files from disk" do
    assert Regex.match?(~r/html/, Bot.take(["header.html", "footer.html"]))
  end
  
end