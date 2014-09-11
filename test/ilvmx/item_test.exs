defmodule ItemTest do
  use ExUnit.Case, async: true

  test "m to make an empty item",
    do: assert %Item{} = Item.m
  
  test "m to make an item with content", 
    do: assert %Item{content: "lol"} = Item.m "lol"

  test "Item.m creates static items",
    do: assert File.exists? "priv/static/#{ Item.m("chat") |> Item.path }"

  test "path to get the path of item", 
    do: assert Regex.match? ~r/obj/, Item.path(Item.m)  
  
  test "m to verify items are unique", 
    do: IT.assert_unique Item.m.unique
  
end