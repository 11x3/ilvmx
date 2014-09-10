defmodule CastleTest do
  use ExUnit.Case

  ## API
  
  test "Castle.exe to boost signals with Castle.Nubspace items (aka magic)." do
    ILvMx.reset!

    Castle.beam! Castle.exe("lol", Program.cmd(fn s -> "nub err roo" end))

    # the Program/fn above is executed... great success.
    assert %Signal{items: ["nub err roo"]} = Castle.exe "lol"
  end
  
  test "Castle.exe! to return signal items. (aka different magic)." do
    ILvMx.reset!

    Castle.beam! Castle.exe("lol", Program.cmd(fn s -> "nub err roo" end))

    # the Program/fn above is executed... great success.
    assert ["nub err roo"] == Castle.exe! "lol"
  end
  
  test "Castle.signal", 
    do: assert %Signal{set: "ilvmx/lolnub"} = Castle.signal
    
  test "Castle.signal.items",
    do: assert is_list Castle.signal.items

  test "Castle.map",
    do: assert %{} = Castle.map


  test "Castle.beam! to broadcast a `Signal`" do
    ILvMx.reset!
    
    assert signal = %Signal{} = Castle.beam! Castle.exe("lol", "nub")
  
    assert [signal] = Castle.signal.items
    assert %{"lol" => [%Signal{item: "nub"}]} = Castle.map
  end

  test "Castle.beam! to install a binary string" do
    signal = %Signal{} = Castle.beam! Castle.exe "ilvmx", Bot.new("todo")
    
    assert Regex.match? ~r/obj/, Item.path(signal.item)
    assert true == File.exists? "priv/static/#{ Item.path(signal.item) }"
    assert "todo" == signal.item.content
  end
  
  test "Castle.beam! to install static content with Bot.take" do
    signal = %Signal{} = Castle.beam! Castle.exe("splash", Bot.new(Bot.take(["header.html", "footer.html"])))

    assert Regex.match? ~r/obj/,      Item.path(signal.item)
    assert File.exists? "priv/static/#{ Item.path(signal.item) }"
    assert Regex.match? ~r/html/i,    signal.item.content
    assert Regex.match? ~r/body/i,    signal.item.content
    assert Regex.match? ~r/footer/i,  signal.item.content
  end
  
  test "Castle.boost? to boost a `Signal` with Castle.Nubspace items." do
    ILvMx.reset!
    
    assert lol = %Signal{} = Castle.beam! Castle.exe("lol", "nub")
    assert sup = %Signal{} = Castle.beam! Castle.exe("sup", "nub")
    
    assert [lol] = Castle.boost! Signal.m "lol"
  end
  
  test "Castle.download to capture `Castle.Nubspace` items",
    do: assert is_list Castle.download 

  test "Game.next?", 
    do: assert %Signal{} = Castle.next? Signal.m

  test "Game.ping!",
    do: assert %Signal{} = Castle.ping! Signal.m


  test "Game.pipe!",
    do: assert %Signal{} = Castle.pipe! Signal.m


  test "Game.archive!",
    do: assert %Signal{} = Castle.archive! Signal.m


  test "Game.galaxy!",
    do: assert %Signal{} = Castle.galaxy! Signal.m

  test "Castle.galaxy for the current network exchange", 
    do: assert "ilvmx" == Castle.galaxy
  
  test "Castle.name", 
    do: assert "ilvmx/lolnub" == Castle.name

  test "Castle.uuid for app-wide UUIDs" do
    assert true == IT.assert_unique Castle.uuid
    assert true == Regex.match? Castle.uuid_regex, Castle.uuid
  end
  
  ## Castle.Plug

  test "system" do
    assert 200 == HTTPotion.get(IT.web "ilvmx").status_code
    assert 200 == HTTPotion.get(IT.web "hello").status_code
    assert 200 == HTTPotion.get(IT.web "system/source").status_code
    assert 200 == HTTPotion.get(IT.web "system/signals").status_code
  end
    
  test "invalids" do
    assert [] == Castle.exe! "something random #{ Castle.uuid }"
    
    # assert "[]" == HTTPotion.get(IT.web "./somethinga/$5").body
    # assert "[]" == HTTPotion.get(IT.web "../something").body
    # assert "[]" == HTTPotion.get(IT.web "../something:else").body
  end
  
  test "splash" do
    assert 200  == HTTPotion.get(IT.web("/")).status_code
    assert Regex.match? ~r/html/, HTTPotion.get(IT.web("/")).body
  end
  
  test "static" do
    assert 200  == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  end
  
end