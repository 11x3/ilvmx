defmodule EventTest do
  use   ExUnit.Case, async: true
    
  test "w" do
    ITIT.assert_event Event.w("#console")
  end
end