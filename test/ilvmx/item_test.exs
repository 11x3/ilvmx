defmodule ItemTest do
  use ExUnit.Case, async: true

  test "Item.w to make an empty item",
    do: assert %Item{} = Item.w
  
  test "Item.w to make an item with content", 
    do: assert %Item{content: "lol"} = Item.w "lol"

  test "Item.w creates static items",
    do: assert File.exists? "priv/static/#{ Item.w("chat") |> Item.path }"

  test "Item.w creates unique individuals", 
    do: IT.assert_unique Item.w.unique
      
  test "Item.path to get the path of item", 
    do: assert Regex.match? ~r/obj/, Item.path(Item.w)  
  
  test "Item.get to pull an item from static", 
    do: assert %Item{} = Item.get(Item.w.unique)
   
  test "Item.set to push properties into item.objects",
    do: assert %Item{object: %{"test" => "lol"}} = Item.set(Item.w, "test", "lol")
  
end