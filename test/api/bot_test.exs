defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Bot
  alias ILM.Nubspace

  test "Bot.set(cupcake, contents)" do
    Bot.set("#chat", "todo")
    
    assert ["todo"] == List.first(Bot.get("#chat")).bucket
  end
  
end