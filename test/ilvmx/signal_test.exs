defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "i" do
    assert %Signal{items: ["todo"]} = Signal.i Signal.m(self, "system/console"), "todo"
  end
  
  test "u" do
    assert %Signal{path: "html/header"} = Signal.u "html/header", Bot.prop "header.html"
    signal = Signal.x self, "html/header"
    assert true == Regex.match? ~r/html/, signal.content
  end
  
end