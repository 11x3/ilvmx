defmodule EffectTest do
  use   ExUnit.Case, async: true

  test "w" do
    assert "idk" == Effect.w("idk").content
  end
end