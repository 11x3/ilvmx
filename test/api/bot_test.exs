defmodule BotTest do
  use ExUnit.Case, async: true

  def signal, do: "signal"

  # World
    
  test "Bot.web" do
    assert false == nil? Bot.web(IT.web("/"))
  end

  # Item
  
  test "Bot.prop" do
    assert true == Regex.match?(~r/html/, Bot.prop("app/index.html"))
  end
  
  test "Bot.drop" do
    assert Bot.prop("tmp/todo") == Bot.drop("tmp/todo", "todo") 
  end
  

  ## NubTests

  # test "Bot.set(nubspace, item)" do
  #   effect = Bot.set "#chat", "todo"
  #   IT.assert_effect effect
  #
  #   # we get a static link
  #   static = Dict.get(effect.content, :static)
  #
  #   assert Regex.match? ~r/obj/, static
  #   assert File.exists?(Path.join("priv/static", static))
  # end
  #
  # test "Bot.get(nubspace)" do
  #   result = Bot.set "#chat", "todo"
  #   static = Dict.get(result.content, :static)
  #
  #   effect = Bot.get "#chat"
  #   IT.assert_effect effect
  # end
  #
  # ## Signals
  #
  # test "Bot.sig(nubspace, item)" do
  # end
  #
  # test "Bot.cap(nubspace, program)" do
  #   Bot.cap "#chat", fn event -> send self, :signal end
  #   Bot.set "#chat", "todo"
  #
  #   assert_received :signal
  # end
  #

end