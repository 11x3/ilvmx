defmodule CastleTest do
  use   ExUnit.Case, async: true

  ## API
  
  test "Castle.uuid for app-wide UUIDs" do
    assert true == IT.assert_unique Castle.uuid
    assert true == Regex.match? Castle.uuid_regex, Castle.uuid
  end
  
  test "Castle.galaxy for the current network exchange", 
    do: assert "#ilvmx" == Castle.galaxy
  
  test "Castle.name", 
    do: assert "#lolnub" == Castle.name

  test "Castle.agent", 
    do: assert is_pid Castle.agent

  test "Castle.signal", 
    do: assert %Signal{} = Castle.signal
    
  test "Castle.signal.items", 
    do: assert is_list Castle.signal.items


  # test "Castle.beam! to broadcast a `Signal`",
  #   do: assert %Signal{path: "lol", set: %Item{}} = Castle.beam! "lol", "nub"

  # test "Castle.capture! to capture `Signal` items",
  #   do: assert %Signal{path: "lol", items: []} = Castle.capture! "lol", Program.cmd fn signal -> signal end
   
  ## Capture signals
  
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