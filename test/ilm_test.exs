defmodule ILMTest do
  use ExUnit.Case, async: true
  
  #todo: add integration tests
  
  test "serves root page" do
    assert "[]" == Bot.web(IT.web("lolnub"))
  end

  test "signals with zero matches" do
    assert %Signal{effects: []} = Signal.x(self(), "notfound")
  end
  
  # test "signals match" do
  #   assert %Signal{effects: [%Effect{content: %Program{}}|tail]} = Signal.x(self(), "lolnub")
  # end
  
end