defmodule NubTest do
  use   ExUnit.Case
  
  test "Nub.w" do
    IT.assert_unique Nub.w("#one #two").unique
  end

  test "push!" do
    assert %Effect{} = ILVMX.Nub.Server.push! "#chat", "todo"
  end

  test "pull!" do
    assert %Effect{} = ILVMX.Nub.Server.pull! "#chat"
  end
end