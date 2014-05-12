defmodule NubspaceTest do
  use   ExUnit.Case
  
  test "pull!" do
    IT.assert_nub Nubspace.pull! "#chat"
  end
    
  test "push!" do
    IT.assert_nub Nubspace.push! "#chat", "todo"
  end
end