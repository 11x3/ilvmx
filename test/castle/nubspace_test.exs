defmodule ILVMX.Nubspace.ServerTest do
  use   ExUnit.Case
  
  test "pull!" do
    IT.assert_nub ILVMX.Nubspace.Server.pull! "#chat"
  end
    
  test "push!" do
    IT.assert_nub ILVMX.Nubspace.Server.push! "#chat", "todo"
  end
end