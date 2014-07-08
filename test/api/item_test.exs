defmodule ItemTest do
  use   ExUnit.Case

  test "Item.object(item)" do
    assert Regex.match? ILM.Castle.uuid_regex, Item.object(Item.w)
  end
    
  test "Item.binary(item)" do
    assert Regex.match? ILM.Castle.uuid_regex, Item.binary(Item.w)
  end
end