defmodule Castle do
  use GenServer.Behaviour

  @moduledoc """
  ILM takes place in an unknown time, in an unknown `Castle` server in 
  the great Kingdom of Nub. Castles are top-level ILM nodes and the 
  `Galaxy` is simply the ILvMx exchange.
  
  Castle, Wizard, and Player are not ILM.namespaced because they are really
  more a part of the API tools, i.e. you could take a vanilla ILM server
  and edit one line in the Castle source or update it dynamically and it
  would switch network protocols.
  """
  
  # Public
  
  @doc """
  Yo.
  """
  def uuid do
    ILM.uuid
  end
  
  @doc """
  ILvMx network exchange.
  """
  def galaxy, do: :ilvmx
  
  @doc """
  Only the mightiest of Nub Doors in the land protect `Castle` "#lolnub".
  """
  def door, do: "#lolnub"
  
  @doc """
  Dispatch the bot.cupcake and return an Event.
  
  Spawn |> Event[unique: uuid]
  """
  def exe!(bot) do
    cake = bot.cupcake
    
    # todo: spawn here
    if is_function cake do
      cupcake_function bot
    end
    if is_binary cake do
      cupcake_binary bot
    end
    
    Event.w bot.unique, bot
  end
  
  @doc """
  Dispatch the bot.cupcake and the wait for and return the completed bot.
  """
  def cmd(bot) do
    event = bot |> exe!
    bot = event.content
    
    bot
  end
  
  
  # Private

  def cupcake_function(bot) do
    # dispatch for the pull shortcut
    try do
      Bot.effect bot, Effect.w(bot, bot.cupcake())
    rescue 
      x in [RuntimeError, ArgumentError, BadArityError] -> 
        Bot.effect bot, Effect.w error: x
    end
  end
  
  def cupcake_binary(bot) do
    # dispatch for the pull shortcut
    results = case String.slice(bot.cupcake, 0..0) do
      # we have a simple
      "#"   -> ILM.Nubspace.pull! bot.cupcake
      "@"   -> String.split(bot.cupcake, "\n") |> Enum.map fn command ->  
        cmd = String.slice(String.lstrip(command), 0..3)
        arg = String.replace(cmd, cmd <> " ", "")
  
        try do
          Bot.effect bot, Effect.w(bot, Cupcake.sugar(cmd, arg).())
        rescue 
          x in [RuntimeError, ArgumentError, BadArityError] -> 
            Bot.effect bot, Effect.w error: x
        end
      end
    end
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end