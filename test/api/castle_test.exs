defmodule CastleTest do
  use   ExUnit.Case, async: true
    
  test "ILM.Castle.uuid" do
    assert true == IT.assert_unique ILM.Castle.uuid
    assert true == Regex.match? ILM.Castle.uuid_regex, ILM.Castle.uuid
  end
  
  test "ILM.Castle.galaxy" do
    assert "#ilvmx" == ILM.Castle.galaxy
  end
  
  test "ILM.Castle.name" do
    assert "#lolnub" == ILM.Castle.name
  end
  
  test "ILM.Castle.upload_limit" do
    assert 0 != ILM.Castle.name
  end
  
  test "push!" do
    assert %Signal{} = Signal.m(self, "/") |> ILM.Castle.push!
  end
  
end