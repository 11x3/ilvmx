defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "x" do
    assert %Signal{effects: ["todo"]} = Signal.x Signal.m(self, "system/console"), "todo"
  end
end