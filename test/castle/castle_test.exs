defmodule CastleTest do
  use   ExUnit.Case
    
  test "ILVMX.Castle.Server.uuid" do
    assert true == IT.assert_unique ILVMX.Castle.Server.uuid
    assert true == Regex.match? ILVMX.Castle.Server.uuid_regex, ILVMX.Castle.Server.uuid
  end
  
  test "ILVMX.Castle.Server.galaxy" do
    assert "#ilvmx" == ILVMX.Castle.Server.galaxy
  end
  
  test "ILVMX.Castle.Server.name" do
    assert "#ilvmx" == ILVMX.Castle.Server.name
  end

  test "#ilvmx #static #kit #html" do
    assert Regex.match? ~r/html/, Bot.get("#ilvmx #static #kit #html").content
  end
end