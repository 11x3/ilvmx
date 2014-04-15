defmodule CupcakeTest do
  use   ExUnit.Case
  
  test "Frosting.from :path, path" do
    assert "#ilm" == Frosting.from "/ilm" 
  end
  


  test "Cupcake.frost" do
    Test.assert_unique (Cupcake.frost """
@set #me #jam
    """
    ).unique
  end

end


# @set #me #jam
# @exe "#ilm #lolnub #players #validate", @player]
# @fps 1 #
# @(~) ["#ilm #signals #players", @player]
# @elm "5x5", "/elm/app"
# | @set :title, "Welcome to lolnub, #{ @player }"       
# | @pip ["#apps #chat nubspace"]           # @ picture in place, or unquote
# | @pip ["#apps #kb"]
# | @pip ["#http #youtube |> #search", "a7x"]
# | @nub ["#apps #footer"]
# ]]
# ... @exe ["#ilm #filters #after #exitpoll", @player]
# |>
# @(!) ["#ilm #signals #players", @player]
# @(!) ["#ilm #signals #players #filter #latest", @player]