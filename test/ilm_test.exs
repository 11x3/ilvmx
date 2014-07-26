defmodule ILMTest do
  use ExUnit.Case

  setup do: ILM.Castle.reset!

  # ## Integration

  test "signals (install)" do
    assert %Signal{item: item = %Item{}} = Signal.i "lolnub", "a"

    assert Regex.match? ~r/obj/, Item.path(item)
    assert true == File.exists? "priv/static/#{ Item.path(item) }"
  end

  test "signals (native)" do
    assert %Signal{item: item = %Item{}} = Signal.i "lolnub", "a"
    assert %Signal{item: item = %Item{}} = Signal.i "lolnub", "b"

    
    assert [a, b] = Signal.x(self, "lolnub").items |> Enum.sort
    assert true == is_binary(a) and is_binary(b)
  end

  test "splash" do
    # splash
    assert 200  == HTTPotion.get(IT.web("")).status_code
    assert true == Regex.match? ~r/html/, HTTPotion.get(IT.web("")).body
  end

  test "img" do
    assert 200  == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  end

  # test "invalids" do
  #  assert %Signal{items: []} = Signal.x self, "something random #{ Castle.uuid }"
  #   assert 404 == HTTPotion.get(IT.web "./something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something").status_code
  #   assert 404 == HTTPotion.get(IT.web "../something:else").status_code
  # end
end