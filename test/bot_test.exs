defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Player
  
  alias ILM.Nubspace

  def hey, do: "hey"
  
  # API
  
  test "Bot.cmd!" do
    IT.assert_bot Bot.cmd! "#chat"
  end
  
  test "Bot.get" do
    IT.assert_bot Bot.get "#chat"
  end
  
  test "Bot.set" do
    IT.assert_bot Bot.set "#chat", "todo"
  end

  test "Bot.exe" do
    # setup
    Bot.cmd! "@set #chat todo"
    
    # test
    bot = Bot.exe "#chat", "todo"
    IT.assert_bot bot
    
    assert ["todo"] == bot.results
  end
  
  test "Bot.cap" do
    capbot = Bot.cap  "#chat", fn event -> send self, :hey end
    sigbot = Bot.cmd! "@set #chat todo"
    
    assert_received :hey
  end
end