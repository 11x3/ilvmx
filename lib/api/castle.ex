defmodule Castle do
  use GenServer.Behaviour
    
  @moduledoc """
  ILM takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILvMx exchange.
  
  Castle, Wizard, and Player are not ILM.namespaced because they are a part 
  of the core API, i.e. you could take a vanilla ILM server and edit one 
  line in the Castle source or update it dynamically and it would switch 
  networks.
  """
  
  # Public

  @doc """
  ILvMx network exchange.
  """
  def galaxy do
    :ilvmx
  end
  
  @doc """
  `Castle` "#lolnub"
  
  # todo: support p2p between castles
  """
  def name do
    "#ilvmx"
  end

  @doc """
  Yo.
  """
  def uuid do
    ILM.uuid
  end

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end