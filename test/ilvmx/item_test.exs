defmodule ItemTest do
  use   ExUnit.Case

  test "items" do
    IT.assert_unique Item.m("lol").unique
  end

end