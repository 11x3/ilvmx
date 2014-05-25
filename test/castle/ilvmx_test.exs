defmodule ILVMX.Test do
  use ExUnit.Case

  test "ILVMX.castle" do
    assert true == is_pid ILVMX.castle
  end
end
