use Jazz

defmodule BotTest do
  use ExUnit.Case, async: true
    
  def signal, do: "signal"
  
  ## NubTests
  
  test "Bot.set(nubspace, item)" do
    effect = Bot.set "#chat", "todo"    
    IT.assert_effect effect
    
    # we get a static link
    static = Dict.get(effect.content, :static)
    
    assert Regex.match? ~r/obj/, static
    assert File.exists?(static)
  end
  
  test "Bot.get(nubspace)" do
    result = Bot.set "#chat", "todo"
    static = Dict.get(result.content, :static)

    effect = Bot.get "#chat"
    IT.assert_effect effect
  end

  test "Bot.cap(nubspace, program)" do
    Bot.cap "#chat", fn event -> send self, :signal end
    Bot.set "#chat", "todo"

    assert_received :signal
  end
    
  ## PropTests
  
  test "Bot.prop(path)" do
    assert true == Regex.match? ~r/html/, Bot.prop("html/header.html")
  end
  
  test "Bot.drop(path, item)" do
    assert Bot.drop("test.html", "<html/>") == Bot.prop("api/test.html")
  end
  
  test "Bot.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Bot.web("http://elixir-lang.org/")
  end
end