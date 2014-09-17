require Logger

defmodule Castle do
  use GenServer

  @epoch :epoch

  @moduledoc """
  ILvMx takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILvMx nodes and the `Galaxy` is simply the ILvMx exchange.

  ILvMx [
    Services [
      Game/Players,
      Plug
    ]
    Castle [
      Wizard,
      Signal [
         item: %{},   # ping/servers
        items: [],    # exe/programs
      ],
      Machine [
        Signals/Programs/Items/Bots
      ],
    ]
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
  
  @doc "Testing shortcut to create, exe, and return a `Signal`."
  def x(signal_path, thing \\ nil) when is_binary(signal_path) do
    Logger.debug "Castle.x: #{signal_path} thing: #{inspect thing}"
    
    execute(Signal.m(signal_path, thing), Castle.signal.items, 0)
  end
  
  @doc "Testing shortcut to create, exe, and return items from Castle.Nubspace at `signal_path`."
  def x!(signal_path, thing \\ nil) when is_binary(signal_path) do
    Logger.debug "Castle.x!: #{signal_path} thing: #{inspect thing}"
    
    execute!(Signal.m(signal_path, thing), Castle.signal.items, 0)
  end
  
  ## API (castle)
    
  @doc "Install a `signal` into Castle.Nubspace."
  def install!(signal = %Signal{}, items \\ [], duration \\ 0) do
    Logger.debug "Castle.install!: #{inspect signal.set}"
    
    #todo: validate signal
    #todo: support regex in signal.set
    
    # promote the signal to a GenServer
    {:ok, machine} = GenServer.start_link(Castle.Machine, nil, debug: [])
    
    signal        = %{signal| source: machine}
    signal_map    = Dict.update(Castle.map, signal.set, [signal], fn signals -> [signal|signals] end)
    signal_items  = [signal|Castle.signal.items]
    
    Application.put_env :ilvmx, :signal, %Signal{Castle.signal| item: signal_map, items: signal_items}
  
    # process the signal/program
    signal = GenServer.call(machine, {:execute, signal, items, duration})
    |> Castle.Wizard.filter?
  end
    
  @doc "Boost `signal` and return a `Signal` with Castle.Nubspace `items`."
  def execute(signal, items \\ [], duration \\ 0) do
    Logger.debug "Castle.execute: #{inspect signal.set}"
    
    # promote the signal to a GenServer
    {:ok, machine} = GenServer.start_link(Castle.Machine, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(machine, {:execute, signal, items, duration})
    |> next?
    |> Castle.Wizard.filter?
    |> pipe!
    |> galaxy!
    |> archive!
  end
  @doc "Boost `signal` a with `items` and return `Signal.items` or a single `item`."
  def execute!(signal, items \\ [], duration \\ 0) do
    results = execute(signal, items, duration).items
    
    if is_list(results) and length(results) < 2 do
      results |> List.first
    else
      results
    end
  end

  @doc "Ping `signal` through `items`."
  def ping!(signal = %Signal{}, items \\ [], duration \\ 0) do
    #Logger.debug "Castle.ping! #{inspect signal}"

    # promote signal to a Machine or full-peer GenServer.
    {:ok, machine} = GenServer.start_link(Castle.Machine, nil, debug: [])
    signal = %{signal| source: machine}
    
    GenServer.call(machine, {:ping, signal, Castle.map[signal.set], duration})
  end
  
  # @doc "Collect a `signal` at `step` for `duration` in Castle.Nubspace."
  # def capture!(signal, step, duration \\ 3000) do
  #   Logger.debug "(x-x-):capture! {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
  #
  #   # start the server
  #   {:ok, machine} = GenServer.start_link(Castle.Machine, nil, debug: [])
  #
  #   # start the signal/program
  #   signal = GenServer.call(machine, {:capture, signal, duration})
  # end
  
  # @doc "#todo: Kill a `signal` already in Nubspace."
  # def break!(signal, token) do
  #   {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])
  #
  #   # process the signal/program
  #   GenServer.call(signal.source, {:break, signal, token})
  # end
  
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
    #Logger.debug "...\\#{ inspect signal }/..............................................................."
    
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
  
  defp epoch_loop(tick \\ 1000, path) do
    #todo: add longer duration ping paths
    
    :timer.sleep(1000)
    
    ping!(Signal.m path)
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
    
    Task.async fn -> epoch_loop(1000,   "ping/every/second") end
    Task.async fn -> epoch_loop(60000,  "ping/every/minute") end
    
    Logger.debug "Castle: #{ inspect castle } default: #{inspect signal}"

    link
  end
end