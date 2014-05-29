defmodule PlugTest do
  use   ExUnit.Case

  test "Prop.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Prop.web("http://localhost:8080/index.html")
  end
end