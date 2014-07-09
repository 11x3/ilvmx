defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "e" do
    assert %Signal{effects: ["todo"]} = Signal.e(Signal.m(self, "system/console"), "todo")
  end
end