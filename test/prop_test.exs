defmodule PropTest do
  use   ExUnit.Case
  
  test "Prop.static(path)" do
    assert true == Regex.match? ~r/Apache/, Prop.static("LICENSE")
  end
end