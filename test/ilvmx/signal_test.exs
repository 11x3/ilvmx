defmodule SignalTest do
  use   ExUnit.Case, async: true
  
  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end

  test "a" do
    assert %Signal{items: ["todo"]} = Signal.a Signal.m(self, "system/console"), "todo"
  end  
end