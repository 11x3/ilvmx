defmodule CastleTest do
  use   ExUnit.Case
  alias Castle
  
  test "Castle.uuid" do
    assert true == IT.assert_unique Castle.uuid 
  end
  
  test "Castle.galaxy" do
    assert :ilvmx == Castle.galaxy
  end
  
  test "Castle.door" do
    assert "#lolnub" == Castle.door
  end
  
  test "Castle.arrow!" do
    assert IT.assert_unique Bot.get("#chat").unique
  end
  
  test "Castle.dove!" do
    assert IT.assert_unique Bot.get("#chat").unique
  end  
end