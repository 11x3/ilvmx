defmodule PlayerTest do
  use   ExUnit.Case
  
  test "Player.anon" do
    IT.assert_player Player.anon
  end

end