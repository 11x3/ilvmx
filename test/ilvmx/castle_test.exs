defmodule CastleTest do
  use   ExUnit.Case, async: true
  
  test "push!" do
    assert %Signal{} = Signal.m(self, "/")
  end
    
  test "Castle.uuid" do
    assert true == IT.assert_unique Castle.uuid
    assert true == Regex.match? Castle.uuid_regex, Castle.uuid
  end
  
  test "Castle.galaxy" do
    assert "#ilvmx" == Castle.galaxy
  end
  
  test "Castle.name" do
    assert "#lolnub" == Castle.name
  end
  
  test "Castle.upload_limit" do
    assert 0 != Castle.name
  end
  
end