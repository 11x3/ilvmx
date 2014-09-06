defmodule ILMTest do
  use ExUnit.Case

  ## Integration
  
  # test "defaults signals" do
  #   assert 200 == HTTPotion.get(IT.web "ilvmx").status_code
  # end
  #
  # test "invalids" do
  #   assert %Signal{items: []} = Castle.exe "something random #{ Castle.uuid }"
  #
  #   assert 404 == HTTPotion.get(IT.web "./something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something:else").status_code
  # end
  #
  # test "splash" do
  #   # splash
  #   assert 200  == HTTPotion.get(IT.web("/")).status_code
  #   assert Regex.match? ~r/html/, HTTPotion.get(IT.web("/")).body
  # end
  #
  # test "static" do
  #   assert 200  == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  # end
  #
  # test "plug / sig/exe/cap" do
  #   assert 200 == HTTPotion.get(IT.web "api/sig").status_code
  #   assert 200 == HTTPotion.get(IT.web "api/cap").status_code
  # end
  
end