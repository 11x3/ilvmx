# tests
ExUnit.start


defmodule IT do
  use ExUnit.Case
  
  def assert_unique(uuid) do  
    assert Regex.match? ILvMx.uuid_regex, uuid
  end

  def assert_nub(suspect) do  
    assert Regex.match? ILvMx.uuid_regex, suspect.unique
  end

  def assert_bot(suspect) do
    assert_unique suspect.unique
  end

  def assert_player(suspect) do
    assert_unique suspect.unique
  end
end


# server
ILvMx.start
