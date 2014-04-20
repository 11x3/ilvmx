defmodule CastleTest do
  use   ExUnit.Case
  
  test "Castle.uuid" do
    assert true == IT.assert_unique Castle.uuid 
  end
  
  test "Castle.galaxy" do
    assert :ilvmx == Castle.galaxy
  end
  
  test "Castle.door" do
    assert "#lolnub" == Castle.door
  end
  
  test "Castle.upload!" do
    IT.assert_bot Castle.upload! Bot.cmd! "#chat"
  end
end