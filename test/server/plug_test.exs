defmodule PlugTest do
  use   ExUnit.Case

  test "Prop.web(path, opts = [])" do
    assert Regex.match? ~r/html/, Bot.web("http://localhost:8080/index.html")
  end
end