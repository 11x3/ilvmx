defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  ## World
    
  test "Bot.web" do
    assert false == nil? Bot.web(IT.web("/"))
  end


  ## Nubspace

  test "list" do
    assert [] == Bot.list "xyz"
    assert []
  end
  
  # test "push" do
  #   effect = Bot.push "chat", "todo"
  #
  #   assert false
  # end
  #
  # test "pull" do
  #   effect = Bot.pull "chat"
  #
  #   assert false
  # end
  #
  # ## Item
  
  test "item" do
    assert %Item{} = Bot.item
  end
  
  # test "set" do
  #   assert %Item{content: %{text: "todo"}} = Bot.set Item.m, :text, "todo"
  # end
  #
  # test "get" do
  #   assert false
  # end
  #
  # test "binaries" do
  #   assert false
  # end
  #
  ## File
  
  test "Bot.take" do
    assert true == Regex.match?(~r/html/, Bot.take("index.html"))
  end
  
  test "Bot.make" do
    assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 
  end
end