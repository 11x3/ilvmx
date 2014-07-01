use Jazz

defmodule BotTest do
  use ExUnit.Case, async: true
    
  def signal, do: "signal"
  
  ## NubTests
  
  test "Bot.set(nubspace, item)" do
    effect = Bot.set "#chat", "todo"    
    ITIT.assert_effect effect
    
    # we get a static link
    static = Dict.get(effect.content, :static)
    
    assert Regex.match? ~r/obj/, static
    assert File.exists?(Path.join("priv/static", static))
  end
  
  test "Bot.get(nubspace)" do
    result = Bot.set "#chat", "todo"
    static = Dict.get(result.content, :static)

    effect = Bot.get "#chat"
    ITIT.assert_effect effect
  end

  ## Signals
  
  test "Bot.sig(nubspace, item)" do
  end
  
  test "Bot.cap(nubspace, program)" do
    Bot.cap "#chat", fn event -> send self, :signal end
    Bot.set "#chat", "todo"

    assert_received :signal
  end
    
  ## PropTests
  
  test "Bot.prop(path)" do
    assert true == Regex.match? ~r/html/, Bot.prop("html/app.html")
  end
  
  test "Bot.drop(path, item)" do
  end
  
  test "Bot.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Bot.web("http://elixir-lang.org/")
  end
end