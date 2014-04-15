defmodule CupcakeTest do
  use   ExUnit.Case
  
  test "Cupcake.from :path, path" do
    assert "#ilm" == Cupcake.from "/ilm" 
  end
  
end
