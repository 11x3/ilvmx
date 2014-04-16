defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Bot
  alias ILM.Nubspace
  
  test "Bot.set" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
  test "Bot.get" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
  test "Bot.exe" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot 
  end
  
  test "Bot.cap" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
  test "Bot.sig" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
end