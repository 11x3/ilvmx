defmodule BotTest do
  use ExUnit.Case
    
  def signal, do: "signal"
  
  ## NubTests
  
  test "Bot.set(nubspace, program)" do
    effect = Bot.set "#chat", "todo"    
    IT.assert_effect effect
    
    # we get a static link
    static = Dict.get(effect.content, :static)
    
    assert Regex.match? ~r/api/, static
    assert File.exists?(static)
  end
  
  test "Bot.get(nubspace)" do
    result = Bot.set "#chat", "todo"
    static = Dict.get(result.content, :static)
        
    effect = Bot.get "#chat"
    IT.assert_effect effect
    assert static in effect.content
  end

  test "Bot.cap(nubspace, program)" do
    Bot.cap "#chat", fn event -> send self, :signal end
    Bot.set "#chat", "todo"

    assert_received :signal
  end
  
  ## PropTests
  
  test "Bot.prop(path)" do
    assert true == Regex.match? ~r/html/, Bot.prop("index.html")
  end
  
  test "Bot.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Bot.web("http://elixir-lang.org/")
  end
  
end