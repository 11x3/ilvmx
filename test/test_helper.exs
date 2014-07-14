# clear the test API
# ["priv/static/obj/*", "priv/static/nub/*"]
# |> Enum.map(&File.rm_rf/1)

use Jazz

# server
ILM.start

# tests
ExUnit.start

defmodule IT do
  use ExUnit.Case
  
  def web(path) do
    "http://localhost:8080/#{ path }"
  end
  
  def assert_unique(uuid) do  
    assert Regex.match? ILM.Castle.uuid_regex, uuid
  end
end