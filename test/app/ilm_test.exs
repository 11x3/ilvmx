defmodule ILM.Test do
  use ExUnit.Case

  # Source

  test "app" do
    assert true == is_pid ILM.castle
  end

  test "has uuids" do
    assert true == Regex.match? ILM.uuid_regex, ILM.uuid
  end

  test "ilm (web)" do
    assert_get "http://localhost:4000/ilm"
  end

  defp get_body(path) do
    HTTPotion.get(path).body
  end
  
  defp assert_get(path) do
    assert 200 == HTTPotion.get(path).status_code
  end
  
end
