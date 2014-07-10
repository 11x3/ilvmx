defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  ## World
    
  test "Bot.web" do
    assert false == nil? Bot.web(IT.web("/"))
  end


  ## Signal
  
  # test "signal a program" do
    #Bot.sig "#chat", fn event -> send self, :signal end
  # end
  
  # test "signal a binary" do
  #   Bot.sig "lolnub", "todo"
  # end

  # test "signal an item" do
  #   Bot.sig "#chat", Bot.get
  # end


  ## Item
  
  # test "Bot.set" do
  #
  # end
  #
  # test "Bot.get" do
  #
  # end


  ## File
  
  test "Bot.prop" do
    assert true == Regex.match?(~r/html/, Bot.prop("index.html"))
  end
  
  test "Bot.drop" do
    assert Bot.prop("tmp/todo") == Bot.drop("todo", "tmp/todo") 
  end
end