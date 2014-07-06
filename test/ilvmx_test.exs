use Jazz

defmodule ILMTest do
  use ExUnit.Case, async: true
  
  #todo: add integration tests
  
  test "serves root page" do    
    %{"signal" => unique } = JSON.decode!(Bot.web IT.web("/"))
    
    IT.assert_unique unique
  end
end