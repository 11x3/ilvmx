defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "i" do
    result = Signal.i "lolnub", "todo"
    
    assert %Signal{item: %Item{content: "todo"}} = result
  end
  
  test "x" do
    assert %Signal{} = Signal.i "html/header", Bot.take "header.html"
  end

  test "a" do
    assert %Signal{items: ["todo"]} = Signal.a Signal.m(self, "system/console"), "todo"
  end
end