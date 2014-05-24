defmodule ILvMx.NubspaceTest do
  use   ExUnit.Case
  
  test "pull!" do
    IT.assert_nub ILvMx.Nubspace.pull! "#chat"
  end
    
  test "push!" do
    IT.assert_nub ILvMx.Nubspace.push! "#chat", "todo"
  end
end