
ILM.start

ExUnit.start

defmodule Test do
  use ExUnit.Case
  alias Script

  def assert_unique(uuid) do  
    assert Regex.match? ILM.uuid_regex, uuid
  end

end

