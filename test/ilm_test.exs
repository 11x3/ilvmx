defmodule ILMTest do
  use ExUnit.Case, async: true
  
  # ## Integration
  
  test "native signals" do
    Signal.u "lolnub", "todo"

    signal = Signal.x self, "lolnub"
    
    assert 1 == length signal.items
    assert %Signal{path: "lolnub", items: [%Item{content: "todo"}]} = signal
  end
  
  # test "web endpoints" do
  #   # invalid
  #   assert 404 == HTTPotion.get(IT.web "./something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something:else").status_code
  #
  #   # splash
  #   assert 200 == HTTPotion.get(IT.web("")).status_code
  #   assert 204 == HTTPotion.get(IT.web("lolnub")).status_code
  #   assert Bot.web IT.web("") == Bot.web IT.web("app")
  # end
  #
  # test "invalids" do
  #   assert %Signal{items: []} = Signal.x self, "something random #{ ILM.Castle.uuid }"
  # end
end