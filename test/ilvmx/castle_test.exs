defmodule CastleTest do
  use ExUnit.Case

  ## API
  
  test "Castle.x to boost signals with Castle.Nubspace items (aka magic)." do
    ILvMx.reset!
    Castle.install! Signal.set("lol", Program.cmd(fn s -> "nub err roo" end))

    # the Program/fn above is executed... great success.
    assert "nub err roo" = Castle.x! "lol"
  end
  
  test "Castle.x to return signal items. (aka different magic)." do
    ILvMx.reset!
    Castle.install! Signal.set("lol", Program.cmd(fn s -> "nub err roo" end))

    # the Program/fn above is executed... great success.
    assert %Signal{items: ["nub err roo"]} = Castle.x "lol"
    assert "nub err roo" == Castle.x! "lol"
  end
  
  test "Castle.signal", 
    do: assert %Signal{path: "ilvmx/lolnub"} = Castle.signal
    
  test "Castle.signal.items",
    do: assert is_list Castle.signal.items

  test "Castle.map",
    do: assert %{} = Castle.map


  test "Castle.install! to broadcast a `Signal`" do
    ILvMx.reset!
    
    assert signal = %Signal{} = Castle.install! Signal.set "lol", "nub"
  
    assert [signal] = Castle.signal.items
    assert %{"lol" => [%Signal{item: "nub"}]} = Castle.map
  end

  test "Castle.install! to install a binary string" do
    signal = %Signal{} = Castle.install! Signal.set "ilvmx", Item.m("todo")
    
    assert Regex.match? ~r/obj/, Item.path(signal.item)
    assert true == File.exists? "priv/static/#{ Item.path(signal.item) }"
    assert "todo" == signal.item.content
  end
  
  test "Castle.install! to install static content with Bot.take" do
    signal = %Signal{} = Castle.install! Signal.set "splash", Item.m(Bot.take ["header.html", "footer.html"])

    assert Regex.match? ~r/obj/,      Item.path(signal.item)
    assert File.exists? "priv/static/#{ Item.path(signal.item) }"
    assert Regex.match? ~r/html/i,    signal.item.content
    assert Regex.match? ~r/body/i,    signal.item.content
    assert Regex.match? ~r/footer/i,  signal.item.content
  end
  
  test "Castle.execute to boost a `Signal` with Castle.Nubspace items." do
    ILvMx.reset!
    assert lol = %Signal{} = Castle.install! Signal.set("lol", "nub")
    
    assert %Signal{path: "lol", items: [%Signal{item: "nub"}]} = Castle.execute Signal.set "lol"
  end
  
  test "Castle.execute! to boost a `Signal` with Castle.Nubspace items." do
    ILvMx.reset!
    
    assert lol = %Signal{} = Castle.install! Signal.set("lol", "nub")
    assert sup = %Signal{} = Castle.install! Signal.set("sup", "nub")
    
    assert lol = Castle.execute Signal.set "lol"
  end
  
  test "Castle.download to capture `Castle.Nubspace` items",
    do: assert is_list Castle.download 

  test "Castle.next?", 
    do: assert %Signal{} = Castle.next? Signal.all
  test "Castle.ping!",
    do: assert %Signal{} = Castle.ping! Signal.all

  test "Castle.pipe!",
    do: assert %Signal{} = Castle.pipe! Signal.all
  test "Castle.archive!",
    do: assert %Signal{} = Castle.archive! Signal.all
  test "Castle.galaxy!",
    do: assert %Signal{} = Castle.galaxy! Signal.all

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
    assert nil == Castle.x! "something random #{ Castle.uuid }"
    
    assert "/" == HTTPotion.get(IT.web "./somethinga/$5").body
    assert "/" == HTTPotion.get(IT.web "../something").body
    assert "/" == HTTPotion.get(IT.web "../something:else").body
  end
  
  test "splash" do
    assert 200  == HTTPotion.get(IT.web("/")).status_code
    assert Regex.match? ~r/html/, HTTPotion.get(IT.web("/")).body
  end
  
  test "static" do
    assert 200  == HTTPotion.get(IT.web("/img/nubspace.jpg")).status_code
  end
  
end