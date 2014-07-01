defmodule PlayerTest do
  use   ExUnit.Case
  
  test "Player.anon!" do
    ITIT.assert_player Player.anon!
  end

  test "Player.arrow!" do
    ITIT.assert_event Player.arrow!("#console")
  end
  
  test "Player.dove!" do
    ITIT.assert_event Player.dove!("#console")
  end
end