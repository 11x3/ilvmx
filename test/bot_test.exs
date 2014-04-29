defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  def hey, do: "hey"
  
  # API
  test "Bot.set" do
    nub = Bot.set "#chat", "todo"
    IT.assert_nub nub
    
    assert ["todo"] = nub.nubcakes
  end
  
  test "Bot.get" do
    Bot.set "#chat", "todo"
    
    nub = Bot.get "#chat"
    IT.assert_nub nub
    
    assert ["todo"] = nub.nubcakes
  end
  
  test "Bot.exe" do
    Bot.set "#chat", fn m -> "lol @ #{ m }" end
    
    bot = Bot.exe "#chat", "hi"
    IT.assert_bot bot
    
    nub = List.first(bot.results).content
    
    assert "lol @ hi" = nub[:result]
  end
  
  test "Bot.cap" do
    Bot.cap "#chat", fn event -> send self, :hey end    
    Bot.exe "#chat"
    
    assert_received :hey
  end

end