# clear the test API
["priv/static/obj/*", "priv/static/nub/*"]
|> Enum.map(&File.rm_rf/1)

# tests
ExUnit.start

defmodule ITIT do
  use ExUnit.Case
  
  def assert_unique(uuid) do  
    assert Regex.match? ILM.Castle.Server.uuid_regex, uuid
  end

  def assert_nub(suspect) do  
    assert Regex.match? ILM.Castle.Server.uuid_regex, suspect.unique
  end

  def assert_bot(suspect) do
    assert_unique suspect.unique
  end

  def assert_event(suspect) do
    assert %Event{} = suspect
  end
  
  def assert_player(suspect) do
    assert_unique suspect.unique
  end
  
  def assert_effect(suspect) do
    assert %Effect{} = suspect
  end
end

# server
ILM.start



