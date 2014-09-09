defmodule SignalTest do
  use ExUnit.Case, async: true
  
  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end

  ## Add to a signal
  
  test "boost! to add items to a `Signal`.",
    do: assert %Signal{items: ["todo"]} = Signal.boost! Signal.m, "todo"

end