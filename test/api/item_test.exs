defmodule ItemTest do
  use   ExUnit.Case
  
  test "Item.path(item)" do
    assert Regex.match? ILM.Castle.uuid_regex, Item.path(Item.w)
  end
  
  # test "Item.w(nubspace, data)" do
  #   assert %Item{} = Item.w("#item", "something")
  # end
  #
  # test "Item.w(nubspace, path)" do
  #   assert %Item{} = Item.w("#item", path: "priv/static/app/app.html")
  # end

end