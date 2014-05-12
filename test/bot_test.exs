defmodule BotTest do
  use ExUnit.Case
    
  def hey, do: "hey"
  
  # API
  
  test "Bot.set" do
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
  
  test "Bot.get(:static, path)" do
  end
  
  test "Bot.get(:web, path)" do
  end
  
  # test "Bot.cap" do
  #   Bot.cap "#chat", fn event -> send self, :hey end
  #   Bot.exe "#chat"
  #   
  #   assert_received :hey
  # end
  # 
  # test "Bot.exe" do
  #   Bot.set "#chat", fn m -> "lol @ #{ m }" end
  #   
  #   bot = Bot.exe "@chat hi"
  #   IT.assert_bot bot
  #   
  #   effect = List.first(bot.results)
  #   
  #   assert "lol @ hi" = effect
  # end
  
  test "Bot.api(nubspace, program)" do
  end
  test "Bot.api(nubspace, function)" do
  end
  
end