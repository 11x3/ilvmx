defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  ## World
    
  test "Bot.web" do
    assert false == nil? Bot.web(IT.web("/"))
    assert true == Regex.match? ~r/html/, Bot.web(IT.web "/" )
  end


  ## Nubspace
  
  test "push" do
    assert %Item{} = Bot.push "chat", "todo"
  end
  
  test "pull" do
    assert [] == Bot.pull "xyz"
  end

  # ## Item
  
  test "item" do
  end

  # test "get" do
  #   assert %Item{} = Bot.push "chat", "todo"
  # end
  #
  # test "set" do
  #   assert %Item{content: %{text: "todo"}} = Bot.set Item.m, :text, "todo"
  # end

  ## File
  
  test "Bot.take" do
    assert true == Regex.match?(~r/html/, Bot.take("index.html"))
  end
  
  test "Bot.make" do
    assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  end
end