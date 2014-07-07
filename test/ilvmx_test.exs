use Jazz

defmodule ILMTest do
  use ExUnit.Case, async: true
  
  #todo: add integration tests
  
  test "serves root page" do
    assert %{} = JSON.decode!(Bot.web(IT.web("/")))
  end
end