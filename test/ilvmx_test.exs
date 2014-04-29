defmodule ILM.Test do
  use ExUnit.Case

  Source

  test "app" do
    assert true == is_pid ILM.castle
  end
  
  test "has uuids" do
    assert true == Regex.match? ILM.uuid_regex, ILM.uuid
  end
  # 
  # test "ilm (web)" do
  #   assert_get "http://localhost:4000/chat"
  # end

end
