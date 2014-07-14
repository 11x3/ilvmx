defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "u" do
    assert :ok = Signal.u "html/header", Bot.prop "header.html"
    assert %{"html/header" => [pid]} = ILM.SignalSupervisor.signals
    assert true == is_pid pid
  end
  
  #
  # test "x" do
  #
  # end
    
  test "i" do
    assert %Signal{items: ["todo"]} = Signal.i Signal.m(self, "system/console"), "todo"
  end
  
end