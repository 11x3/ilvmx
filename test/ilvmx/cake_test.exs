defmodule CakeTest do
  use ExUnit.Case, async: true
  
  ## File

  test "Bot.make to write files to disk", 
    do: assert Bot.take("tmp/todo") == Bot.make("todo", "tmp/todo") 

end