defmodule EffectTest do
  use   ExUnit.Case, async: true

  test "w" do
    assert %Effect{content: "idk"} = Effect.w(self(), "idk")
  end
end