defmodule EffectTest do
  use   ExUnit.Case
  
  test :w do
    assert "idk" == Effect.w("idk").content
  end
end