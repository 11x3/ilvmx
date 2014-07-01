defmodule PlugTest do
  use   ExUnit.Case, async: true
  
  @ilvmx "http://localhost:8080/"
  
  test "Bot.web(localhost)" do
    assert Regex.match?(~r/html/, Bot.web(@ilvmx))
    
    # assert "" == Bot.web("#{ @ilvmx }/api/set/")
    # assert "" == Bot.web("#{ @ilvmx }/api/cap/")
    # assert "" == Bot.web("#{ @ilvmx }/api/obj/")
    # assert "" == Bot.web("#{ @ilvmx }/api/api/")
    # assert "" == Bot.web("#{ @ilvmx }/api/sig/")
    # assert "" == Bot.web("#{ @ilvmx }/api/")
    
    # # /get => /(nub)
    # assert "" == Bot.web("#{ @ilvmx }/(nub)/(nub)/(nub)/(nub)/(nub)/(nub)")
  end
  
  test "Bot.web with invalid paths" do
    assert Regex.match? ~r/404/, Bot.web @ilvmx <> "../something"
    assert Regex.match? ~r/404/, Bot.web @ilvmx <> "../something"
  end
   
end