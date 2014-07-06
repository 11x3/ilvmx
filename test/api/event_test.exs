defmodule SignalTest do
  use   ExUnit.Case, async: true

  test "w" do
    assert %Signal{} = Signal.w(self, "#console")
  end
end