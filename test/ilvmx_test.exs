defmodule ILvMx.Test do
  use ExUnit.Case

  Source

  test "app" do
    assert true == is_pid ILvMx.castle
  end
  
  test "has uuids" do
    assert true == Regex.match? ILvMx.uuid_regex, ILvMx.uuid
  end
  
  test "web: /console" do
    #assert_get "http://localhost:4000/console"
  end

end
