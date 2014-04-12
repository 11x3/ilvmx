defmodule BotTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import Bot
  alias ILM.Nubspace
  
  @opts ILM.WebServer.init([])
  
  test "Bot.w is unique" do
    Test.assert_unique Bot.w.unique
  end
  
  test "Bot.exe (nubspace)" do
    Test.assert_unique (Bot.exe "#ilm").unique
  end
  
  test "Bot.exe (nub)" do
  end
  
  test "Bot.plug" do  
  end

  test "Bot.cmd" do
    Test.assert_unique (Bot.cmd "#ilm #nubspace" do
      "lol"
    end).unique
  end
  
end