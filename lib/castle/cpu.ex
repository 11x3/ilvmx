defmodule Castle.CPU do
  use GenServer
  
  ## API
  
  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  
  ## Execute
  
  @doc "Execute a signal on the Castle.CPU."
  def execute!(signal) do
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # process the signal/program
    GenServer.call(server, {:execute, signal, signal.source, server})
    |> Castle.Wizard.review?
    |> Services.Tower.commit!
  end

  
  ## Capture
  
  @doc "Capture and repeatedely execute Program on Castle.CPU."
  def capture!(signal, duration) do
    signal = execute!(signal)
    
    IO.inspect "(x-x-):capture! {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # start the signal/program
    signal = GenServer.call(server, {:capture, signal, duration})

    signal
    |> Castle.Wizard.review?
    |> Services.Tower.beam!
  end
  
  ## Install
  
  @doc "Install `signal` to disk to provide `item` or `program` in Castle.Nubspace."
  def install!(signal) do
    install!(signal, signal.item)
  end
  def install!(signal, item) when is_binary(item) do
    install!(signal, Program.app(item))
  end
  def install!(signal, item) when is_function(item) do
    install!(signal, Program.cmd(item))
  end
  def install!(signal, item = %Item{}) do
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, signal, debug: [])

    # start the signal/program
    GenServer.call(server, {:install, signal})
  end
  
  
  ## Kill
  
  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal, token) do
  #   {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])
  #
  #   # process the signal/program
  #   GenServer.cast(server, {:kill, signal, token})
  #
  #   signal
  # end
  
  
  ## Callbacks
  
  def handle_call({:execute, signal, client, server}, from, state) do
    IO.inspect "(x-x-).execute!: #{inspect signal.path}"
    
    effects = Bot.pull(signal.path) |> Enum.map fn item ->      
      item = Bot.get item
      
      # if item = %Program{} do
      #   %{item| data: %{signal: signal} } |> Program.exe
      # else
        item
      #end
    end
    
    {:reply, Signal.a(signal, effects), nil}
  end

  def handle_cast({:capture, signal, duration}, state) do
    IO.inspect "(x-x-):capture {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)
    
    #todo: check for kill9 on signal

    #add dynamic :boost signal/server
    # todo: fix these Castle sigmaps
    sigmap = %{signal: signal.path, server: self, item: String.slice(inspect(signal.item), 0..42)}
    
    #todo: check for existing item
    signals(signal.path, sigmap)

    cap_loop(signal_agent, signal.item, duration)
    
    #todo: return a ownership token
    {:noreply, nil}
  end
  
  def handle_call({:install, signal}, from, state) do
    IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
    
    # graph the item
    
    #todo: return a ownership token
    {:reply, %{signal| item: Bot.push(signal.path, signal.item)}, state}
  end

  
  ## private

  defp cap_loop(signal_agent, program, duration) do
    signal = Agent.get signal_agent, fn signal -> signal end

    receive do
      {message, content} -> IO.inspect "(x-x-).message.unknown: #{inspect {message, content}}"

    after duration ->
      try do
        Agent.update signal_agent, fn signal -> Program.exe(%{program| data: signal}) end
      rescue
        x in [RuntimeError, ArgumentError, BadArityError] ->
          IO.inspect "(x-x-).setup_castle.FAILED: #{inspect x}"
      end
    end
    
    Agent.get signal_agent, fn signal -> signal end
  end

  defp signals(path, sigmap) do
    Agent.update signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end
  
  defp signals_agent do
    Application.get_env :ilvmx, :signals
  end

  
  ## GenServer
  
  def handle_info(message, _nil) do
    {:noreply, _nil}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
  def start_link(default \\ nil) do
    GenServer.start_link(Castle.CPU, default)
  end
end
