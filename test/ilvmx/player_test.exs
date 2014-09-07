defmodule PlayerTest do
  use   ExUnit.Case

  test "Player.anon!",
    do: assert %Player{} = Player.anon!
  
  test "Player.items to collect a player's items.",
    do: assert [] = Player.anon!.items
      
  
end