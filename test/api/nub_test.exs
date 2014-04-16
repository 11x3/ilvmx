defmodule NubTest do
  use   ExUnit.Case
  
  test "Nub.w" do
    IT.assert_unique Nub.w("#one #two").unique
  end
end