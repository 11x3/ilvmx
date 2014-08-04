defmodule ILMTest do
  use ExUnit.Case

  setup do: ILM.Castle.reset!

  ## Integration

  test "invalids" do
    assert %Signal{items: []} = Signal.x self, "something random #{ Castle.uuid }"
    
    assert 404 == HTTPotion.get(IT.web "./something").status_code
    assert 404 == HTTPotion.get(IT.web "../something").status_code
    assert 404 == HTTPotion.get(IT.web "../something:else").status_code
  end
  
  test "splash" do
    # splash
    assert 200  == HTTPotion.get(IT.web("/")).status_code
    assert Regex.match? ~r/html/, HTTPotion.get(IT.web("/")).body
  end

  test "static" do
    assert 200  == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  end

  test "signals (install/execute)" do
    assert %Signal{item: item_a = %Item{}} = Signal.i "lolnub", "a"
    assert %Signal{item: item_b = %Item{}} = Signal.i "lolnub", "b"

    assert item_a.content == "a"
    assert Regex.match? ~r/obj/, Item.path(item_a)
    assert File.exists? "priv/static/#{ Item.path(item_a) }"

    assert [a = %{}, b = %{}] = Signal.x(self, "lolnub").items |> Enum.sort
  end
end