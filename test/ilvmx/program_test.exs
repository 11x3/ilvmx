defmodule ProgramTest do
  use ExUnit.Case
  
  test "Program.m" do
    assert %Program{} = Program.m(self)
  end
  
end
