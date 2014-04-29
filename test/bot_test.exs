defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Player
  
  alias ILM.Nubspace

  def hey, do: "hey"
  
  # API
  test "Bot.set" do
    nub = Bot.set "#chat", "todo"
    IT.assert_nub nub
    
    assert ["todo"] = nub.nubcakes
  end
  
  test "Bot.get" do
    nub = Bot.get "#chat"
    IT.assert_nub nub
    
    assert [] = nub.nubcakes
  end
  
  # test "Bot.cap" do
  #   capbot = Bot.cap "#chat", fn event -> send self, :hey end
  #   throw IO.inspect capbot
  #   
  #   sigbot = Bot.exe "#chat"
  #   
  #   assert_received :hey
  # end
  
  # test "Bot.exe" do
  #   # setup
  #   Bot.exe "@set #chat todo"
  #   
  #   # test
  #   bot = Bot.exe "#chat"
  #   IT.assert_bot bot
  #   
  #   throw IO.inspect bot
  # end


end