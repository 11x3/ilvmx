# server
ILM.Castle.reset!
ILM.Castle.start

# tests
ExUnit.start

defmodule IT do
  use ExUnit.Case
  
  def web(path) do
    "http://localhost:8080/#{ path }"
  end
  
  def assert_unique(uuid) do
    assert Regex.match? Castle.uuid_regex, uuid
  end
  
  def assert_web_page(binary) do
    assert Regex.match? ~r/html/, binary
  end
end