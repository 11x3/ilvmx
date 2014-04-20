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
  def uuid, do: ILM.uuid
  
  @doc """
  ILvMx network exchange.
  """
  def galaxy, do: :ilvmx
  
  @doc """
  Only the mightiest of Nub Doors in the land protect `Castle` "#lolnub".
  """
  def door, do: "#lolnub"
  
  @doc """
  Dispatch and return `bot`.  
  """
  def upload!(bot = Bot[]) do
    bot |> ILM.Dungeon.execute!
  end


  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end