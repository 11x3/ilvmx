defmodule PlayerTest do
  use   ExUnit.Case

  test "Player.anon!" do
    assert %Player{} = Player.anon!
  end
end