defmodule EffectTest do
  use   ExUnit.Case
  
  test :w do
    assert "idk" == Event.w("idk").content
  end
end