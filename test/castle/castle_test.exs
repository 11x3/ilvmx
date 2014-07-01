defmodule CastleTest do
  use   ExUnit.Case, async: true
    
  test "ILM.Castle.Server.uuid" do
    assert true == ITIT.assert_unique ILM.Castle.Server.uuid
    assert true == Regex.match? ILM.Castle.Server.uuid_regex, ILM.Castle.Server.uuid
  end
  
  test "ILM.Castle.Server.galaxy" do
    assert "#ilvmx" == ILM.Castle.Server.galaxy
  end
  
  test "ILM.Castle.Server.name" do
    assert "#ilvmx" == ILM.Castle.Server.name
  end
end