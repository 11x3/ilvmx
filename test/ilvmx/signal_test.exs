defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "i" do    
    assert %Signal{item: %Item{content: "todo"}} = Signal.i "lolnub", "todo"
    
    assert %Signal{item: item = %Item{}} = Signal.i "lolnub", "a"
    assert Regex.match? ~r/obj/, Item.path(item)
    assert true == File.exists? "priv/static/#{ Item.path(item) }"
  end
  
  test "x" do
    assert %Signal{} = Signal.i "splash", Bot.take "index.html"
  end

  test "a" do
    assert %Signal{items: ["todo"]} = Signal.a Signal.m(self, "system/console"), "todo"
  end
end