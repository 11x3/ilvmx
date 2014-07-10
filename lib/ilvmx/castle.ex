defmodule ILM.Castle do
  use GenServer
  
  @cache :cache
  @epoch :epoch

  @moduledoc """
  ILM takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILM exchange.

  # todo: add Castle.config[:name]
  # todo: support p2p between castles
  """
  
  
  @doc """
  Castle's astral connection to the higher planes of the ILvMx network.
  """
  def gate!(signal) do
    signal
    |> ILM.Castle.Wizard.Server.please?
    |> ILM.Castle.Signal.Server.boost!
    |> ILM.Castle.CPU.Server.execute!
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Castle.Tower.Server.signal!
  end
  
  
  ## Native
  
  @doc """
  ILM network exchange.
  """
  def galaxy do
    "#ilvmx"
  end
  
  @doc """
  Castle name.
  """
  def name do
    "#lolnub"
  end
  
  @doc """
  Return an UUID.
  """
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  @doc """
  Return the regex that matches ILM.Castle.uuids
  """
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc """
  Return the general max size of an upload.
  """
  def upload_limit do
    8_000_000
  end
  
  
  ## Private

  # Return the app cache.
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
  
  
  ## GenServer

  def start_link do
    # castle-wide cache
    cache

    link = GenServer.start_link(__MODULE__, nil)

    # setup plug adapters
    Plug.Adapters.Cowboy.http ILM.Plug.Server, [], port: 8080
    #todo: support ILM.config for starting options
    
    link
  end
end