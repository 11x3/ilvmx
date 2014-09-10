require Logger

defmodule Castle do
  use GenServer

  @epoch :epoch

  @moduledoc """
  ILvMx takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILvMx nodes and the `Galaxy` is simply the ILvMx exchange.

  Castle [
    Services [
      Plug
    ],
    Game [
      Map/Wizard/Players
    ],
    CPU [
      Signals/Programs/Items/Bots
    ],
  ]
  """
  
  ## System
  
  @doc "Boost `signal_path` and return a `Signal` with Castle.Nubspace `items`."
  def exe(signal_path, item \\ nil) when is_binary(signal_path) do
    Castle.boost? Signal.m signal_path, item
  end
  
  @doc "Boost `signal_path` and magically return an item or list of `items`."
  def exe!(signal_path, item \\ nil) when is_binary(signal_path) do
    Castle.boost?(Signal.m signal_path, item).items
  end
  
  @doc "Return the `Castle.signal` of yore."
  def signal do
    Application.get_env :ilvmx, :signal
  end
  
  @doc "Our signal map."
  def map do
    Castle.Game.map
  end


  ## API

  @doc "Ping a `signal_path` of the Castle.Nubspace and return *all* `Castle.signals`."
  def beam!(signal = %Signal{}) do
    Logger.debug "Castle.beam!: #{signal.set}"
    
    signal |> Castle.Game.host!
  end
  
  @doc """
  Boost `signal` with appropriate Castle.Nubspace items. `boost?` creates Castle GenServers 
  which basically means every boost?'ed signal becomes a full Castle peer by design.
  """
  def boost!(signal = %Signal{}) do
    Logger.debug "Castle.boost!: #{inspect signal.set}"
    
    boost?(signal).items
  end
  def boost?(signal = %Signal{}) do
    Logger.debug "Castle.boost?: #{inspect signal.set}"
    
    # promote the signal to a GenServer
    # todo: search for existing GenServers at signal/path 
    {:ok, castle} = GenServer.start_link(Castle, signal, debug: [])
    
    # process the signal/program
    GenServer.call(castle, {:boost, signal, Castle.map[signal.set]})
  end
  
  def handle_call({:boost, signal, items}, from, state) do    
    {:reply, 
      Castle.Game.run!(signal, items)
      |> Castle.Wizard.filter?
      |> ping!
      |> pipe!
      |> galaxy!
      |> archive!
      |> next?, 
    state}
  end
  
  @doc "Return updated items and noops our worker."
  def next?(signal \\ nil) do
    # unless nil?(items) or not is_list(items) do
    #   Application.put_env :ilvmx, :signal, Signal.boost!(signal, items)
    # end
    
    #{:ok, karma: "#todo", next: "#todo"}
    
    signal
  end
  
  @doc "Return the `Castle.signal.items` – all of them. #todo: add streams"
  def download do
    Logger.debug "Castle.download"

    signal.items
  end

  ## Signals/Pipes/Networks aka Distribution.
  
  #todo: register/forward observers
    
  @doc "#todo: forward sequentially to all ping! observers."
  def ping!(signal) do
    #todo: post "castle/signals/commit/#{signal.unique}"
    
    signal
  end

  @doc "#todo: Send `signal` to external configured pipelines."
  def pipe!(signal) do
    
    signal
  end

  @doc "#todo: Share signals with the galaxy."
  def galaxy!(signal) do

    signal
  end
  
  @doc "Save `signal` to disk as configured."
  def archive!(signal) do
    # todo: add/update commit times of signal
    Logger.debug "...\\#{ inspect signal.unique }/..............................................................."
    
    signal
  end
  
  
  ## Public
  
  @doc "ILvMx network exchange."
  def galaxy do
    "ilvmx"
  end
  
  @doc "Castle name."
  def name do
    "#{ galaxy }/lolnub"
  end
  
  @doc "Return an UUID."
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  
  ## Misc.
  
  @doc "Return the regex that matches Castle.uuids"
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc "Return the general max size of an upload."
  def upload_limit do
    8_000_000
  end
  
  
  ## Private
  

  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
    
    {:noreply, nil}
  end
  
  def handle_info(message, state) do
    {:noreply, nil}
  end
  
  def handle_info(_args, _state) do
    {:noreply, nil}
  end

  def start_link(signal \\ nil) do
    link = {:ok, castle} = GenServer.start_link(Castle, signal)
    
    Logger.debug "Castle: #{ inspect castle } default: #{inspect signal}"

    link
  end
end