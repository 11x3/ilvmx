defmodule Castle.CPU do
  use GenServer
  
  ## API
  
  ## Install
  
  @doc "Install `signal` to disk to provide `item` in Castle.Nubspace."
  def install!(signal) do
    install!(signal, signal.item)
  end
  def install!(signal, item) when is_binary(item) do
    install!(signal, Program.app(item))
  end
  def install!(signal, item) when is_function(item) do
    install!(signal, Program.cmd(item))
  end
  def install!(signal, item) do
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, signal, debug: [])

    # start the signal/program
    GenServer.call(server, {:install, signal})
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
    |> Castle.Wizard.review?
    |> Castle.Arcade.beam!
  end

  ## Execute
  
  @doc "Execute a signal *once* in the Castle.Nubspace."
  def execute!(signal) do
    IO.inspect "(x-x-).execute!: #{inspect signal}"
    
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(server, {:execute, signal, signal.source, server})
    |> Castle.Wizard.review?
    |> Castle.Arcade.commit!
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

  def handle_call({:install, signal}, from, state) do
    IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
    
    #todo: return a ownership token
    signal = Signal.a(signal, Bot.push(signal.path, signal.item))
    
    {:reply, signal, state}
  end

  def handle_call({:capture, signal, duration}, from, state) do
    IO.inspect "(x-x-):capture {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    #todo: check for kill9 on signal
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)

    #todo: add dynamic :boost signal/server
    #todo: fix these Castle sigmaps
    sigmap = %{signal: signal.path, server: self, item: String.slice(inspect(signal.item), 0..42)}

    #todo: check for existing item
    Castle.signals(signal.path, sigmap)

    cap_loop(signal_agent, signal.item, duration)

    # #todo: return a ownership token
    {:noreply, nil}
  end
    
  def handle_call({:execute, signal, client, server}, from, state) do
    IO.inspect "(x-x-):execute: client: #{inspect client} server: #{inspect server}"
    
    items = Bot.get(Bot.pull signal.path)
    
    {:reply, Signal.a(signal, items), state}
  end

  def handle_call({:suspend, signal, token}, from, state) do
    IO.inspect "(x-x-):suspend {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
  
    {:reply, signal}
  end
  
  
  ## private

  defp cap_loop(signal_agent, program, duration) do
    signal = Agent.get signal_agent, fn signal -> signal end

    receive do
      {message, content} -> IO.inspect "(x-x-).message.unknown: #{inspect {message, content}}"

    after duration ->
      try do
        Agent.update signal_agent, fn signal -> Program.exe(signal) end
      rescue
        x in [RuntimeError, ArgumentError, BadArityError] ->
          IO.inspect "(x-x-).cap_loop: #{inspect x}"
      end
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
