defrecord Cupcake,
 nubspace: nil,
 commands: [],
 captures: [],
    emits: [],
     gets: [],
     sets: [],
     exes: [],
     pips: [],
     elms: [],
   unique: nil,
      fps: 1 do

  @moduledoc """
  `Cupcakes` are cloud apps that power `Castle` `Bots`. They are simple to
  write and easy to understand. As you can see above, the Cupcake and Castle 
  server track the exact type of commands the app will be issuing. 

  Cupcake's big top idea is to define an entire cloud app, in an easy enough 
  way to type and code inside a <textarea> or be sent via SMS or through any 
  number of services. You should be able to develop an entire cloud app in 
  an ASCII and humane-level language in less than a minute. Assume other roles 
  are in place (accounts, funds, network, etc) and the goal is to be able to 
  dev an internet wide ILM app on a phone, deploy with a single TXT message or 
  request and it'll do the right thing and your cash/karma will be accounted
  for correctly. :D

  The actual commands of the app are stored inside :commands to be executed
  every :fps (haha, yeah ask for 500fps, not on my server punk!) or whatever 
  the Castle server chooses to give you.
  
  So every :fps the Castle server will execute a `Spell` to run your `Cupcake`
  app, which may then update and recapture the entire world state, or only
  what it wants. Signals and emits.
  """
    
  # """
  #   @app "#me #jam"
  #   @exe ["#ilm #lolnub #players #validate", @player]
  #   @fps 1 #
  #   @(~) ["#ilm #signals #players", @player]
  #   | @elm "5x5", "/elm/app"
  #   | @set :title, "Welcome to lolnub, #{ @player }"       
  #   | @cap ["#apps #chat"]           # @ picture in place, or unquote
  #   | @pip ["#apps #friends"]
  #   | @pip ["#web #youtube |> #search", "a7x"]
  #   | @nub ["#apps #footer"]
  #   ]]
  #   ... @exe ["#ilm #filters #after #exitpoll", @player]
  #   |>
  #   @(!) ["#ilm #signals #players", @player]
  #   @(!) ["#ilm #signals #players #filter #latest", @player]
  # """

  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
  def w(args \\ []) do
    apply __MODULE__, :new, [Enum.concat(args, [unique: ILM.uuid])]
  end
  
  @doc """
  Pair the cmd + arg.
  """
  def sugar(cmd, arg) do
    case cmd do
      "@get" -> fn -> Bot.get arg end
    end
  end
  
  def from(cake) do
    String.replace("##{ cake }", "/", "")
  end
end