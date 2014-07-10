defmodule ItemTest do
  use   ExUnit.Case

  test "items" do
    IT.assert_unique Item.m.unique
  end
  
  test "item objects" do
    item = Item.m
    Item.object item, "lolnub"
    
    assert "lolnub" == Item.object item
  end
  
end