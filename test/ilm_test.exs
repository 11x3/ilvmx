defmodule ILMTest do
  use ExUnit.Case, async: true
  
  # ## Integration
  
  test "native signals" do
    Signal.u "lolnub", "todo"
    signal = Signal.x self, "lolnub"
        
    assert 1 <= length signal.items
    assert %Signal{path: "lolnub", items: items} = signal
  end
  
  test "web endpoints" do
    # # splash
    assert 200 == HTTPotion.get(IT.web("")).status_code
    assert 200 == HTTPotion.get(IT.web("app")).status_code
    assert 200 == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  end

  # test "invalids" do
  #  assert %Signal{items: []} = Signal.x self, "something random #{ ILM.Castle.uuid }"
  #   assert 404 == HTTPotion.get(IT.web "./something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something:else").status_code
  # end
end