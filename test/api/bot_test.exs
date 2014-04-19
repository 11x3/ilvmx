defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Bot
  alias ILM.Nubspace

  def hey, do: "hey"
  
  test "Bot.set" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
  test "Bot.get" do
    bot = Bot.set "#chat", "todo"
    IT.assert_bot bot
  end
  
  test "Bot.get" do
    bot = Bot.get "#chat"
  end

  test "Bot.cap" do
    # capture the signal
    event  = Bot.cap "#chat", fn event -> send self, :hey end
    result = Bot.set "#chat", "todo"

    assert "#chat" == event.content
    assert is_pid event.source
      
    assert_received :hey
  end
  
end