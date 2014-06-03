defmodule Program do
defstruct    setup: %{},
              code: %{},
              data: %{},
            unique: nil
  
  def run(event, event.program) do
    
    event
  end
  
  def w(:native, [setup: setup, code: code]) do
    # Program.app "#me #jams" do
    #   Bot.exe "#me #ping", "#me #buds #jeff"
    #   Bot.exe "#ilm #filters #after #exitpoll", "#me"
    #   Bot.sig "#signals #players", "#me"
    #   Bot.exe "#ilm #signals #players #filter #latest", "#me"
    # end
  end
  def w(:dab, [setup: setup, code: code]) do
    # @dab #me #jams
    # | @app "5x5", "/elm/app"
    # | @set :title, "Welcome to lolnub!"       
    # | @cap ["#apps #chat"]           # @ picture in place, or unquote
    # | @pip ["#apps #friends"]
    # | @pip ["#web #youtube |> #search", "a7x"]
    # | @nub ["#apps #footer"]
    # @end
  end
  def w(:markdown, [setup: setup, code: code]) do
    #todo: render markdown
  end
  
  @moduledoc """
  The sound of Dab.
  http://www.youtube.com/watch?v=NQapSNIZDys
  
  The art of Program.
  # set "@example args"
  # get "#example"
  
  # sig "#example args"
  # cap "#example args"
  # exe "#example args"
  # pip "#effects @pipe #take 5"
  """
end