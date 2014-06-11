defmodule PlugTest do
  use   ExUnit.Case, async: true

  test "Bot.web(localhost)" do
    assert Regex.match? ~r/html/, Bot.web("http://localhost:8080/")
  end
end