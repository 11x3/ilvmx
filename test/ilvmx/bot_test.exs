defmodule BotTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Bots are stateless and work with side effects. Bots mostly
    revolve around this set of concepts:
    
    Bot = [
      World,
      Nubspace,
      Item,
      File
    ]
    
    All processes should consider using Bots to interact with
    the primitives.
  """
  
  def signal, do: "signal"

  ## World
    
  test "Bot.web to grab web pages" do
    IT.assert_web_page Bot.web(IT.web("/"))
  end


  ## Nubspace
  
  test "Bot.push to link items in nubspace" do
    assert %Item{} = Bot.push "chat", "todo"
  end


  ## Item
  
  test "Bot.set to create static items" do
    assert %Item{content: "todo"} = Bot.set "todo"
  end


  ## File

  test "Bot.make to write files to disk" do
    assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  end
  
  test "Bot.take to read files from disk" do
    assert Regex.match?(~r/html/, Bot.take(["header.html", "footer.html"]))
  end
  
end