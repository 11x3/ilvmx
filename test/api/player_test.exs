defmodule PlayerTest do
  use   ExUnit.Case
  
  test "Player.anon!" do
    IT.assert_player Player.anon!
  end

  test "Player.arrow!" do
    IT.assert_event Player.arrow!("#console")
  end
  
  test "Player.dove!" do
    IT.assert_event Player.dove!("#console")
  end
end