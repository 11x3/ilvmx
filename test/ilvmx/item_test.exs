defmodule ItemTest do
  use   ExUnit.Case

  test "m to make an `Item`." do
    IT.assert_unique Item.m("lol").unique
  end

end