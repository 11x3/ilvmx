defmodule ItemTest do
  use   ExUnit.Case
  
  test "Item.binary(item)" do
    assert Regex.match? ILM.Castle.uuid_regex, Item.binary(Item.w)
  end

end