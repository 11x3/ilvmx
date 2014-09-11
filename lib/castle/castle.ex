require Logger

defmodule Castle do
  use GenServer

  @epoch :epoch

  @moduledoc """
  ILvMx takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILvMx nodes and the `Galaxy` is simply the ILvMx exchange.

  Castle [
    Signal [
       item: %{},   # ping/servers
      items: [],    # exe/programs
    ],
    Services [
      Plug
    ],
    Game [
      Map/Wizard/Players
    ],
    Machine [
      Signals/Programs/Items/Bots
    ],
  ]
  """
  
  ## System
  
  @doc "Return the `Castle.signal` of yore."
  def signal do
    Application.get_env :ilvmx, :signal
  end
  
  @doc "Our signal map."
  def map do
    Castle.signal.item
  end
  
  @doc "Testing shortcut to create and execute a signal from a binary."
  def x(signal_path, thing \\ nil) when is_binary(signal_path) do
    Logger.debug "Castle.x: #{signal_path} thing: #{inspect thing}"
    
    execute!(Signal.m(signal_path, thing), Castle.signal.items, 0)
  end
  
  
  ## API (castle)
  
  @doc "Install a `signal` into Castle.Nubspace."
  def install!(signal = %Signal{}, items \\ [], duration \\ 0) do
    Logger.debug "Castle.install!: #{inspect signal.set}"
    
    #todo: validate signal
    
    # add it to the castle if the signal stick around..

    # todo: support regex in signal.set
    signal_map    = Dict.update(Castle.map, signal.set, [signal], fn signals -> [signal|signals] end)
    signal_items  = [signal|Castle.signal.items]
    
    Application.put_env :ilvmx, :signal, %Signal{Castle.signal| item: signal_map, items: signal_items}
  
    # promote the signal to a GenServer
    {:ok, cpu} = GenServer.start_link(Castle.Machine, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(cpu, {:execute, signal, items, duration})
    |> Castle.Wizard.filter?
  end
  
  @doc "Boost `signal` and return a `Signal` with Castle.Nubspace `items`."
  @doc "Boost `signal` and return a `Signal` with Castle.Nubspace `items`."
  def execute(signal, items \\ [], duration \\ 0) do
    Logger.debug "Castle.execute: #{inspect signal.set}"
    
    # promote the signal to a GenServer
    {:ok, cpu} = GenServer.start_link(Castle.Machine, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(cpu, {:execute, signal, items, duration})
    |> next?
    |> Castle.Wizard.filter?
    |> pipe!
    |> galaxy!
    |> archive!
  end
  def execute!(signal, items \\ [], duration \\ 0) do
    execute(signal, items, duration).items
  end

  @doc "Ping `signal` through `items`."
  def ping!(signal = %Signal{}, items \\ [], duration \\ 0) do
    #Logger.debug "Castle.ping! #{inspect signal}"

    {:ok, cpu} = GenServer.start_link(Castle.Machine, nil, debug: [])
        
    # oh yeah, we're going to hit them all unless you say so...
    GenServer.cast(cpu, {:execute, signal, Castle.map[signal.set], duration})
    
    %{signal| source: cpu}
  end
  
  @doc "Return an updated `signal` to the Castle."
  def next?(signal = %Signal{}) do
    # unless nil?(items) or not is_list(items) do
    #   Application.put_env :ilvmx, :signal, Signal.items?(signal, items)
    # end
    
    #{:ok, karma: "#todo", next: "#todo"}
    
    signal
  end
  
  
  ### API (guest)
  
  @doc "#todo: Send `signal` to external configured pipelines."
  def pipe!(signal = %Signal{}) do
    
    signal
  end

  @doc "#todo: Share signals with the galaxy."
  def galaxy!(signal = %Signal{}) do

    signal
  end
  
  @doc "Save `signal` to disk as configured."
  def archive!(signal = %Signal{}) do
    Logger.debug "...\\#{ inspect signal }/..............................................................."
    
    # todo: add/update commit times of signal
    
    signal
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
  
  defp epoch_loop do
    # exe 10/sec
    :timer.sleep(1000)
    
    ping!(Signal.m "ping/1000")
    
    epoch_loop
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

  def start_link(signal \\ nil) do
    link = {:ok, castle} = GenServer.start_link(Castle, signal)
    
    Task.async &(epoch_loop/0)
        
    Logger.debug "Castle: #{ inspect castle } default: #{inspect signal}"

    link
  end
end