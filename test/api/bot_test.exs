defmodule BotTest do
  use ExUnit.Case
    
  def hey, do: "hey"
  
  test "Bot.set(nubspace, program)" do
    nub = Bot.set "#chat", "todo"
    IT.assert_nub nub
    
    assert ["todo"] = nub.effects
  end
  
  test "Bot.get(nubspace)" do
    Bot.set "#chat", "todo"
    
    nub = Bot.get "#chat"
    IT.assert_nub nub
    
    assert ["todo"] = nub.effects
  end
  
  test "Bot.cap(nubspace, program)" do
    Bot.cap "#chat", fn event -> send self, :hey end    
    Bot.exe "#chat"
    
    assert_received :hey
  end
  
  test "Bot.exe(program)" do
    Bot.set "#chat", fn m -> "lol @ #{ m }" end
    
    bot = Bot.exe "#chat hi"
    IT.assert_bot bot
  end
end