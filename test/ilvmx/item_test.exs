defmodule ItemTest do
  use   ExUnit.Case

  test "make" do
    IT.assert_unique Item.m("lol").unique
  end

end