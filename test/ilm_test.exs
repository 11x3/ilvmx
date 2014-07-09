defmodule ILMTest do
  use ExUnit.Case, async: true
  
  ## Integration
    
  # test "serves root page" do
  #   assert 200 == HTTPotion.get(IT.web("lolnub")).status_code
  # end
  
  test "signals with zero matches" do
    assert %Signal{effects: []} = Signal.x(self(), "something random #{ ILM.Castle.uuid }")
  end  
end