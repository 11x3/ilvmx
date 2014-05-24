defmodule Castle do
  use GenServer.Behaviour
    
  @moduledoc """
  ILvMx takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILvMx nodes and the `Galaxy` is simply the ILvMx exchange.
  
  Castle, Wizard, and Player are not ILvMx.namespaced because they are a part 
  of the core API, i.e. you could take a vanilla ILvMx server and edit one 
  line in the Castle source or update it dynamically and it would switch 
  networks.
  """

  # Native

  @doc """
  ILvMx network exchange.
  """
  def galaxy do
    :ilvmx
  end
  
  @doc """
  `Castle` "#lolnub"
  
  # todo: add Castle.config[:name]
  # todo: support p2p between castles
  """
  def name do
    "#ilvmx"
  end

  @doc """
  Yo.
  """
  def uuid do
    ILvMx.uuid
  end

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end