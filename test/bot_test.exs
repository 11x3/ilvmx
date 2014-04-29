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
  
  test "Bot.cap" do
    Bot.cap "#chat", fn event -> send self, :hey end    
    Bot.exe "#chat"
    
    assert_received :hey
  end

end