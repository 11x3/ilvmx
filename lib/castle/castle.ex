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
  
  @doc "Boost `signal_path` with Castle.Nubspace items."
  def x(signal_path) when is_binary(signal_path) do
    Castle.boost? Signal.m signal_path
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
  def boost?(signal = %Signal{}) do
    Logger.debug "Castle.boost?: #{inspect signal.set}"
    
    # promote the signal to a GenServer
    {:ok, castle} = GenServer.start_link(Castle, signal, debug: [])
    
    # process the signal/program
    signal = GenServer.call(castle, {:boost, signal, Castle.map[signal.set]})
        
    signal
  end
  
  @doc "Return updated items and noops our worker."
  def next?(items \\ nil) do
    unless nil?(items) or not is_list(items) do 
      Application.put_env :ilvmx, :signal, Signal.boost!(signal, items)
    end
    
    {:ok, karma: "#todo", next: "#todo"}
  end
  
  @doc "Return the `Castle.signal.items` – all of them. #todo: add streams"
  def download do
    Logger.debug "Castle.download"

    signal.items
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
  
  def handle_call({:boost, signal, items}, from, state) do
    Logger.debug ".x.x.<execute {signal.set: #{inspect signal.set} signal.item: #{inspect signal.item} signal.items: #{inspect signal.items}}"
    
    {:reply, Castle.Game.run!(signal, items), state}
  end
  
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

  def start_link(default \\ nil) do
    link = {:ok, castle} = GenServer.start_link(Castle, default)
    
    Logger.debug "Castle: #{ inspect castle }"

    link
  end
end