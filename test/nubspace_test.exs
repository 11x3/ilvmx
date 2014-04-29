defmodule NubspaceTest do
  use   ExUnit.Case
  
  test "pull!" do
    IT.assert_nub ILM.Nubspace.pull! "#chat"
  end
    
  test "push!" do
    IT.assert_nub ILM.Nubspace.push! "@set #chat todo"
  end

end