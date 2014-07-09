defmodule ILMTest do
  use ExUnit.Case, async: true
  
  #todo: add integration tests
  
  test "serves root page" do
    assert Regex.match? ~r/nub\/lolnub\/meta/, Bot.web(IT.web("lolnub"))

  end

  test "signals" do
    assert %Signal{effects: [%Effect{source: "nub/lolnub/meta"}]} = Signal.x self(), "lolnub"
  end
end