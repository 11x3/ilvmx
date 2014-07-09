defmodule ILMTest do
  use ExUnit.Case, async: true
  
  #todo: add integration tests
  
  test "serves root page" do
    assert Regex.match? ~r/nub\/lolnub\/meta/, Bot.web(IT.web("lolnub"))
  end

  test "signals match" do
    assert %Signal{effects: [%Effect{content: %Program{}}|tail]} = Signal.x self(), "lolnub"
  end
  
  test "signals don't match" do
    assert %Signal{effects: [nil, %Effect{content: 404}]} = Signal.x self(), "404"
  end
  
end