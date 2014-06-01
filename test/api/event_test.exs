defmodule EventTest do
  use   ExUnit.Case
  
  # def w(program, player \\ nil) do
  
  test "w" do
    Event.w("#console")
    |> IT.assert_event
  end
  
end