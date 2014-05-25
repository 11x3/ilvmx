defmodule CastleTest do
  use   ExUnit.Case
    
  test "ILVMX.Castle.Server.uuid" do
    assert true == IT.assert_unique ILVMX.Castle.Server.uuid 
  end
  
  test "ILVMX.Castle.Server.galaxy" do
    assert :ilvmx == ILVMX.Castle.Server.galaxy
  end
  
  test "ILVMX.Castle.Server.name" do
    assert "#ilvmx" == ILVMX.Castle.Server.name
  end
  
  test "Castle.uuid" do
    assert true == Regex.match? ILVMX.Castle.Server.uuid_regex, ILVMX.Castle.Server.uuid
  end
  
  test "web: /console" do
    #assert_get "http://localhost:4000/console"
  end
  
end