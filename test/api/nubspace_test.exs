defmodule NubspaceTest do
  use   ExUnit.Case
  alias ILM.Nubspace
  
  test "Nubspace.nubs" do
    refute nil? Nubspace.nubs
  end
  
  test "Nubspace.get(nubspace) returns new nub when none exist" do
    Test.assert_unique (Nubspace.get "#ilm #lolnub").unique
  end
  
  test "Nubspace.put(nub) returns nub" do
    refute nil? Nubspace.put Nub.w
  end

  test "Nubspace.put(nub) stores nub" do
    # create and put a new Nub into subspace
    nub = Nubspace.put Nub.w member: "idk"
    
    # grab all nubs, and map to assert the Nub we just spaced is present.
    assert true == Nubspace.nubs(:tree) |> Enum.any? fn n -> n = Nub[unique: nub.unique] end
  end
    
end