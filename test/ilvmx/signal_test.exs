defmodule SignalTest do
  use ExUnit.Case, async: true


  test "Signal.all to make a system (catch all) Signal." do
    castle_path = Castle.name
    
    assert %Signal{path: castle_path} = Signal.all "lol"
  end
      
  test "Signal.set to create a signal with the given item",
    do: assert %Signal{path: "lol", item: "todo"} = Signal.set "lol", "todo"
  
  
  
  test "Signal.boost to add items to an existing Signal",
    do: assert %Signal{items: ["todo"]} = Signal.boost Signal.all, "todo"

end