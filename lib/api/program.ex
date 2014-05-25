defmodule Program do
defstruct    setup: %{},
              code: [],
              data: %{},
            unique: nil

  @doc """
  Run commands of a `program`.
  """
  def run(program) do    
    IO.inspect program
    
    program
  end

  # get "#example"
  # set "@example args"
  # sig "![#example] args"
  # cap "![#example] args"
  # exe "#example args"
  # pip "#results |> #take 5"

  # Program.cmds do
  #   !me @jams
  #   !me !profile @friends jeff
  #   #lolnub #players #ping
  #   #ilm #filters #after #exitpoll @me
  #   #signals #players @me
  #   #ilm #signals #players #filter #latest @me
  # end

  #@me @debug fn p -> IO.inspect p end

  # @cap #ilm #signals #players @do
  # | @elm "5x5", "/elm/app"
  # | @set :title, "Welcome to lolnub!"       
  # | @cap ["#apps #chat"]           # @ picture in place, or unquote
  # | @pip ["#apps #friends"]
  # | @pip ["#web #youtube |> #search", "a7x"]
  # | @nub ["#apps #footer"]
  # @end

end