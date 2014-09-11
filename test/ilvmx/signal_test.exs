defmodule SignalTest do
  use ExUnit.Case, async: true
  
  test "m" do
    assert %Signal{set: "lol"} = Signal.m "lol"
  end

  ## Add to a signal
  
  test "boost to add items to a `Signal`.",
    do: assert %Signal{items: ["todo"]} = Signal.boost Signal.m, "todo"

end