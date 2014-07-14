defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "u" do
    assert :ok = Signal.u "html/header", Bot.prop "header.html"
    assert :ok = Signal.u "lolnub", "todo"
    assert %{"html/header" => [pid1], "lolnub" => [pid2]} = ILM.SignalSupervisor.signals
    assert true == is_pid pid1
    assert true == is_pid pid2
  end
  
  test "x" do
    assert :ok = Signal.u "html/header", Bot.prop "header.html"
  
    assert "" == Signal.x self, "html/header"
  end
    
  test "i" do
    assert %Signal{items: ["todo"]} = Signal.i Signal.m(self, "system/console"), "todo"
  end
  
end