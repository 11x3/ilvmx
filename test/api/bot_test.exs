defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Bot
  alias ILM.Nubspace
  
  test "Bot.set(cupcake, static_content)" do
    Bot.set "#chat", "todo"
    
    assert ["todo"] == (Bot.get "#chat").cupcakes
  end
    
end