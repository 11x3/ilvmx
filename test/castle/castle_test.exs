defmodule CastleTest do
  use   ExUnit.Case, async: true
    
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
end