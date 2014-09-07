defmodule GameTest do
  alias Castle.Game
  use ExUnit.Case, async: true
  
  ## Game

  # test "Game.on?",
  #   do: assert [%Item{}] = Game.on?(Player.anon!).items


  test "Game.commit!",
    do: assert %Signal{} = Game.commit! Signal.m
  
  
  test "Game.ping!",
    do: assert %Signal{} = Game.ping! Signal.m
  
  
  test "Game.pipe!",
    do: assert %Signal{} = Game.pipe! Signal.m
  
  
  test "Game.archive!",
    do: assert %Signal{} = Game.archive! Signal.m

  
  test "Game.galaxy!",
    do: assert %Signal{} = Game.galaxy! Signal.m

end