
ILM.start

ExUnit.start

defmodule IT do
  use ExUnit.Case
  alias Script

  def assert_unique(uuid) do  
    assert Regex.match? ILM.uuid_regex, uuid
  end
  
  def assert_nub(suspect) do  
    assert Regex.match? ILM.uuid_regex, suspect.unique
  end
  
  def assert_bot(suspect) do
    assert_unique suspect.unique
    assert true 
  end
end

