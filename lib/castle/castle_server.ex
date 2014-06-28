defmodule ILVMX.Castle.Server do
  use GenServer
  
  @cache :cache
  @epoch :epoch

  @moduledoc """
  ILVMX takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILVMX nodes and the `Galaxy` is simply the ILVMX exchange.

  # todo: add Castle.config[:name]
  # todo: support p2p between castles
  """

  ## Native
    
  @doc """
  ILVMX network exchange.
  """
  def galaxy do
    "#ilvmx"
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


  ## Private
  
  def castle_setup do
    # Load our custom Castles here.
    project   = File.cwd!
  
    # Check and load custom castle scripts.
    castledir = Path.join(project, "castle")
      
    if File.exists?(castledir) do
      castles = File.ls!(castledir) |> Enum.each fn file ->
        castlefile = Path.join(castledir, file)
      
        if Path.extname(castlefile) == ".exs" do
          IO.inspect "@@@ castle: #{ Path.basename(castlefile) }"
          
          Code.eval_file castlefile
        end
      end
    end
  end
  
  ## GenServer

  def start_link do
    # castle-wide cache
    cache

    link = :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
    
    # eval castle scripts
    castle_setup
    
    # setup plug adapters
    Plug.Adapters.Cowboy.http ILVMX.Plug.Server, [], port: 8080
    #todo: support ILM.config for starting options
    
    link
  end
end