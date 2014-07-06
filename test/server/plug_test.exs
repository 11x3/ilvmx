defmodule PlugTest do
  use   ExUnit.Case, async: true

  @ilvmx "http://localhost:8080/"

  test "with invalid paths" do
    assert Regex.match? ~r/404/, Bot.web @ilvmx <> "../something"
    assert Regex.match? ~r/404/, Bot.web @ilvmx <> "./something"
    assert Regex.match? ~r/404/, Bot.web @ilvmx <> "../something:else"
  end

end