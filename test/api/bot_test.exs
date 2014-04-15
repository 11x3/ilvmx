defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Bot
  alias ILM.Nubspace

  test "Bot.set(cupcake, static_content)" do
    Bot.set "#chat", "todo"
    
    nub = List.first Bot.get "#chat"
    
    assert ["todo"] == nub.cupcake
  end
  
  # test "Bot.set(cupcake, function)"
  
end