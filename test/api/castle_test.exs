defmodule CastleTest do
  use   ExUnit.Case
  
  test "Castle" do
    assert :ilvmx == Castle.galaxy
  end
  
  test "Castle.door" do
    assert "#lolnub" == Castle.door
  end
end