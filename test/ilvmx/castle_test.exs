defmodule CastleTest do
  use   ExUnit.Case, async: true

  test "Castle.uuid for app-wide UUIDs" do
    assert true == IT.assert_unique Castle.uuid
    assert true == Regex.match? Castle.uuid_regex, Castle.uuid
  end
  
  test "Castle.galaxy for the current network exchange" do
    assert "#ilvmx" == Castle.galaxy
  end
  
  test "Castle.name" do
    assert "#lolnub" == Castle.name
  end

end