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
  Send a `Cupcake` carrying `Bot` into the Castle, return an Event back that
  be captured and signaled or ignored.
  
  Spawn |> Event[unique: uuid] 
  """
  def arrow!(bot = Bot[]) do
    ILM.Wizard.deflect! bot
  end

  @doc """
  Send a Cupcake message into the Castle and stream results. Good for caps
  and sigs.
  
  Spawn |> Wait |> Event[unique: uuid] |> End |> Bot
  """
  def dove!(bot = Bot[]) do
    ILM.Wizard.befriend! bot
  end
  
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end