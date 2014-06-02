defmodule BotTest do
  use ExUnit.Case
    
  def hey, do: "hey"
  
  ## NubTests
  
  test "Bot.set(nubspace, program)" do
    effect = Bot.set "#chat", "todo"    
    IT.assert_effect effect
    
    # we get a static link
    assert Regex.match? ~r/api/, Dict.get(effect.content, :static)
  end
  
  test "Bot.get(nubspace)" do
    Bot.set "#chat", "todo"
    
    effect = Bot.get "#chat"
    IT.assert_effect effect
  end

  test "Bot.cap(nubspace, program)" do
    Bot.cap "#chat", fn event -> send self, :hey end
    
    Bot.set "#chat", "todo"

    assert_received :hey
  end
  
  ## PropTests
  
  test "Bot.prop(path)" do
    assert true == Regex.match? ~r/html/, Bot.prop("index.html")
  end
  
  test "Bot.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Bot.web("http://elixir-lang.org/")
  end
  
end