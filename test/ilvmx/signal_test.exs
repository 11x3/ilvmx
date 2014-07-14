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
    assert true == is_pid List.first(ILM.SignalSupervisor.signals["lolnub"])
  end
  
  test "x" do
    assert :ok = Signal.u "html/header", Bot.prop "header.html"
  
    assert %Signal{content: {:server, pid}} = Signal.x self, "html/header"
    assert true == is_pid pid
  end
    
  test "i" do
    assert %Signal{items: ["todo"]} = Signal.i Signal.m(self, "system/console"), "todo"
  end
  
end