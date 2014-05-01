defmodule CastleTest do
  use   ExUnit.Case
    
  test "Castle.uuid" do
    assert true == IT.assert_unique Castle.uuid 
  end
  
  test "Castle.galaxy" do
    assert :ilvmx == Castle.galaxy
  end
  
  test "Castle.name" do
    assert "#lolnub" == Castle.name
  end
  
  test "Castle.door" do
    assert true == is_binary Castle.door
  end
  
end