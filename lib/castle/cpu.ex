defmodule Castle.CPU do
  use GenServer
  import Castle
  
  ## API

  ## Execute
  
  @doc "Execute signal matches for `duration` in the Castle.Nubspace."
  def execute!(signal, duration \\ 1000) do
    IO.inspect "(x-x-).execute!: #{inspect signal}"
    
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(server, {:execute, signal, signal.source, server})
    
    signal
    |> Castle.Wizard.review?
    |> Castle.Arcade.commit!
  end
  
  ## Install
  
  @doc "Boost a `signal` with optionally provided `item` in Castle.Nubspace."
  def boost!(signal \\ "/") do
    boost!(signal, signal.item)
  end
  def boost!(signal, item) when is_binary(item) do
    boost!(signal, Program.app(item))
  end
  def boost!(signal, item) when is_function(item) do
    boost!(signal, Program.cmd(item))
  end
  def boost!(signal, item) do
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, signal, debug: [])

    # start the signal/program
    GenServer.call(server, {:boost, signal})
  end

  ## Capture
  
  @doc "Collect a signal path for `duration` in Castle.Nubspace."
  def capture!(signal, duration \\ 1000) do
    signal = execute!(signal)
    
    IO.inspect "(x-x-):capture! {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # start the signal/program
    signal = GenServer.call(server, {:capture, signal, duration})
    
    signal
    |> Castle.Wizard.review?
    |> Castle.Arcade.beam!
  end
  
  
  ## Suspend
  
  @doc "#todo: Kill a `signal` already in Nubspace."
  def suspend!(signal, token) do
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # process the signal/program
    GenServer.call(server, {:kill, signal, token})

    signal
  end
  
  
  
  ## Callbacks

  def handle_call({:execute, signal, client, server}, from, state) do
    IO.inspect "(x-x-):execute: client: #{inspect client} server: #{inspect server}"
    
    # map Program
    #     \ compile program
    #     \ unquote functions
    #     \ parse cakedown
    #   \ execute program
    #   \ pull data out of program
    #   \ store program.data into signal.items {:item, x}

    
    # |> Program.compile
    # |> Program.before
    # |> Program.main
    # |> Program.after
    
    items = Bot.get(Bot.pull signal.path)
    
    {:reply, Signal.a(signal, items), state}
  end

  #todo: add :duration to :install
  def handle_call({:boost, signal}, from, state) do
    IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
    
    #todo: return a ownership token
    signal = Signal.a(signal, Bot.push(signal.path, signal.item))
    
    {:reply, signal, state}
  end

  def handle_call({:capture, signal, duration}, _from, _state) do
    IO.inspect "(x-x-):capture {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    #todo: check for kill9 on signal
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)

    #todo: add dynamic :boost signal/server
    #todo: fix these Castle sigmaps
    sigmap = %{signal: signal.path, server: self, item: String.slice(inspect(signal.item), 0..42)}

    #todo: check for existing item
    Castle.signals(signal.path, sigmap)

    # #todo: return a ownership token
    {:reply, cap_loop(signal_agent, signal.item, duration), nil}
  end
    
  def handle_call({:kill, signal, token}, from, state) do
    IO.inspect "(x-x-):suspend {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
  
    {:reply, signal}
  end
  
  
  ## private

  defp cap_loop(signal_agent, program, duration) do
    receive do
      {message, content} -> IO.inspect "(x-x-).message.unknown: #{inspect {message, content}}"

      Agent.update signal_agent, fn signal -> Program.exe(signal) end
      
    after duration -> true
    end
    
    Agent.get signal_agent, fn signal -> signal end
  end

  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
  end
  
  def handle_info(message, state) do
    {:reply, state}
  end

  def start_link(default \\ nil) do
    GenServer.start_link(Castle.CPU, default)
  end
end
