defmodule ILVMX.Castle.Server do
  use GenServer.Behaviour
  
  @cache :cache
  @epoch :epoch

  @moduledoc """
  ILVMX takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILVMX nodes and the `Galaxy` is simply the ILVMX exchange.
  
  Castle, Wizard, and Player are not ILVMX.namespaced because they are a part 
  of the core API, i.e. you could take a vanilla ILVMX server and edit one 
  line in the Castle source or update it dynamically and it would switch 
  networks.
  
  # todo: add Castle.config[:name]
  # todo: support p2p between castles
  """

  # Native
  
  def arrow!(event) do
    event |> ILVMX.Castle.Wizard.Server.please?
  end
  
  @doc """
  ILVMX network exchange.
  """
  def galaxy do
    :ilvmx
  end
  
  @doc """
  Castle name.
  """
  def name do
    "#ilvmx"
  end

  @doc """
  Return an UUID.
  """
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  @doc """
  Return the regex that matches ILVMX.Castle.Server.uuids
  """
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc """
  Return the app cache.
  """
  def cache do
    store = Process.get @cache
    if !store do
      store = ConCache.start_link(
        touch_on_read: true,
        ttl: :timer.seconds(0)
      )
      Process.put @cache, store
    end
    store
  end

  # GenServer Callbacks

  def start_link do
    # Private
    cache
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end