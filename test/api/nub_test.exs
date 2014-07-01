defmodule NubTest do
  use   ExUnit.Case
  
  test "Nub.w" do
    ITIT.assert_unique Nub.w("#one #two").unique
  end

  test "push!" do
    assert %Effect{} = Nub.push! "#chat", "todo"
  end

  test "pull!" do
    assert %Effect{} = Nub.pull! "#chat"
  end
end