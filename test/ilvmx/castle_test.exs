defmodule CastleTest do
  use   ExUnit.Case, async: true

  ## API
  
  test "Castle.uuid for app-wide UUIDs" do
    assert true == IT.assert_unique Castle.uuid
    assert true == Regex.match? Castle.uuid_regex, Castle.uuid
  end
  
  test "Castle.galaxy for the current network exchange", 
    do: assert "ilvmx" == Castle.galaxy
  
  test "Castle.name", 
    do: assert "ilvmx/lolnub" == Castle.name


  test "Castle.signal", 
    do: assert %Signal{path: "ilvmx/lolnub"} = Castle.signal
    
  test "Castle.signal.items",
    do: assert is_list Castle.signal.items

  test "Castle.map",
    do: assert %{} = Castle.map


  test "Castle.beam! to broadcast a `Signal`" do
    ILM.reset!
    
    assert signal = %Signal{} = Castle.beam! Signal.m("lol", "nub")
  
    assert [signal] = Castle.signal.items
    assert %{"lol" => [%Signal{let: "nub"}]} = Castle.map
  end
  
  test "Castle.download to capture `Castle.Nubspace` items",
    do: assert is_list Castle.download 

  test "Castle.next? to update `Castle` to return to the Castle.",
    do: assert {:ok, _next} = Castle.next?


  # test "capture all Castle.Nubspace signals with Castle.signals",
  #   do: assert %Signal{} = Castle.x(Signal.m "lolnub")
  #
  # ## Signals
  #
  # test "install a binary string" do
  #   signal = %Signal{item: %Item{}} = Castle.sig "ilvmx", "todo"
  #
  #   assert Regex.match? ~r/obj/, Item.path(signal.item)
  #   assert true == File.exists? "priv/static/#{ Item.path(signal.item) }"
  #   assert "todo" == signal.item.content
  # end
  #
  # test "install static content with Bot.take" do
  #   signal = %Signal{item: %Item{}} = Castle.sig "splash", Bot.take(["header.html", "footer.html"])
  #
  #   assert Regex.match? ~r/obj/, Item.path(signal.item)
  #   assert File.exists? "priv/static/#{ Item.path(signal.item) }"
  #   assert Regex.match? ~r/html/i, signal.item.content
  #   assert Regex.match? ~r/body/i, signal.item.content
  #   assert Regex.match? ~r/footer/i, signal.item.content
  # end

end