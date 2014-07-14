defmodule ILMTest do
  use ExUnit.Case, async: true
  
  ## Integration
  test "signals" do
    signal = Signal.x self, "lolnub"
    assert 1 == length signal.items
    assert %Signal{path: "lolnub", content: %Program{}} = List.first(signal.items)
  end
    
  test "endpoints" do
    # invalid
    assert 404 == HTTPotion.get(IT.web "./something").status_code
    assert 404 == HTTPotion.get(IT.web "../something").status_code
    assert 404 == HTTPotion.get(IT.web "../something:else").status_code

    # splash
    assert 200 == HTTPotion.get(IT.web("")).status_code
    assert 204 == HTTPotion.get(IT.web("lolnub")).status_code
    assert Bot.web IT.web("") == Bot.web IT.web("app")
  end
  
  test "invalids" do
    assert %Signal{items: []} = Signal.x self, "something random #{ ILM.Castle.uuid }"
  end
end