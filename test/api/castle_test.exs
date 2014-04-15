defmodule CastleTest do
  use   ExUnit.Case
  
  test "Castle" do
    assert :ilvmx == Castle.galaxy
  end
  
  test "Castle.door" do
    assert "#lolnub" == Castle.door
  end
  
  # test "Castle.arrow!" do
  #   Bot.set "#chat", "todo"
  #   
  #   assert ["todo"] == Castle.arrow! Bot.get "#chat"
  # end
  
end