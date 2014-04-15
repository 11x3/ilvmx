defmodule EventTest do
  use   ExUnit.Case
  
  test :w do
    assert "idk" == Event.w("idk").content
    assert "lol" == Event.w(Nub.w member: "lol").content.member
  end
end