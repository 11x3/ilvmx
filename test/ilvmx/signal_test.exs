defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "m" do
    assert %Signal{} = Signal.m(self)
    assert %Signal{} = Signal.m(self, [])
    assert %Signal{} = Signal.m(self, "system/console")
  end
  
  test "u" do
    assert :ok = Signal.u "lolnub", "todo"
    assert :ok = Signal.u "html/header", Bot.take "header.html"
    
    assert [%{agent: apid, server: spid}] = Application.get_env(:ilvmx, :signals)["lolnub"]
  end
  
  test "x" do
    assert :ok = Signal.u "html/header", Bot.take "header.html"
    assert %Signal{} = Signal.x self, "html/header"
  end
    
  # test "signal a program" do
  #   Signal.x "#chat", fn event -> send self, :signal end
  # end
  
  # test "signal a binary" do
  #   Signal.x "lolnub", "todo"
  # end

  # test "signal an item" do
  #   Signal.x "#chat", Bot.get
  # end
    
  test "i" do
    assert %Signal{items: ["todo"]} = Signal.i Signal.m(self, "system/console"), "todo"
  end
end