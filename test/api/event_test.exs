defmodule EventTest do
  use   ExUnit.Case, async: true
    
  test "w" do
    IT.assert_event Event.w("#console")
  end
end