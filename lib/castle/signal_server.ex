defmodule ILM.SignalServer do
  use GenServer

  @signals :signals
  
  @moduledoc """
  SignalServer or Nubspace server is a mapping of Signals -> Items 
  on disk/memory/galaxy that are sent and compiled top the CPU.
  """
  
  ## Boosts
  
  @doc "Collect signals from Nubspace."
  def boost!(signal) do
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
    IO.inspect "(x-x-):SignalServer.boost! {signal: #{signal.path}, client: #{inspect self}}"

    # process the signal/program
    signal = GenServer.call(server, {:boost, signal, signal.source, server})
    
    signal
  end
  
  def handle_call({:boost, signal, client, server}, _from, _nil) do  
    {:ok, boost_agent} = Agent.start_link(fn -> signal end)

    # collect signals todo: add collect nil/all signals support
    signals = Application.get_env(:ilvmx, @signals)[signal.path] || []
    IO.inspect "(x-x-)~tSignals: #{inspect signals}"
    
    signals |> Enum.each fn sigmap ->
      send sigmap.server, {:boost, boost_agent, client, server}
      
      IO.inspect "(x-x-):SignalServer.(:match) {signal: #{inspect signal}, sigmap: #{inspect sigmap}}"
    end
    
    {:reply, boost_loop(boost_agent, client, server), nil}
  end

  def boost_loop(boost_agent, client \\ nil, server \\ nil) do
    receive do
      {:update, boost_agent, server} ->
        IO.inspect "(x-x-):SignalServer.boost_loop :update"
        
        boost_loop(boost_agent, client, server)
    after
      1_000 -> boost_agent
    end
    
    # return the Signal
    Agent.get(boost_agent, fn signal -> signal end)
  end
  
  ## GenServer
  
  def handle_info({:DOWN, ref, process, _pid, _reason}, _nil) do
    {:noreply, _nil}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
  def init(opts \\ nil) do
    {:ok, opts}
  end
  
  def start_link(opts \\ nil) do
    IO.inspect "(x-x-):SignalServer.start_link.self: #{inspect self} opts: #{inspect opts}"
    
    GenServer.start_link(__MODULE__, opts)
  end
  
end