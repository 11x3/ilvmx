defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  ## World
    
  test "Bot.web" do
    assert false == nil? Bot.web(IT.web("/"))
  end

  ## Signal
  
  test "signal an item" do
    
  end
  
  # test "Bot.cap(nubspace, program)" do
  #   Bot.cap "#chat", fn event -> send self, :signal end
  #   Bot.set "#chat", "todo"
  #
  #   assert_received :signal
  # end


  ## Item
  
  test "Bot.set" do

  end

  test "Bot.get" do

  end


  ## File
  
  test "Bot.prop" do
    assert true == Regex.match?(~r/html/, Bot.prop("app/index.html"))
  end
  
  test "Bot.drop" do
    assert Bot.prop("tmp/todo") == Bot.drop("tmp/todo", "todo") 
  end
end