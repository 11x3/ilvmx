defmodule ILM.SignalServer do
  use GenServer

  @castle_signals :castle_signals
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """

  ## API

  @doc "Put `signal` into Nubspace."
  def upload!(signal, program \\ nil) do
    #debug: :trace, :log, :statistics

    {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
    IO.inspect "(x-x-):SignalServer.upload! {signal: #{inspect signal.path}, server: #{inspect server}}"
    
    # process the signal/program
    GenServer.cast(server, {:upload, signal, program, server})
  end
  
  @doc "Collect signals from Castle."
  def boost!(signal) do

    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
    IO.inspect "(x-x-):SignalServer.boost! {signal: #{inspect signal.path}, client: #{inspect self}}"

    # process the signal/program,
    GenServer.cast(server, {:boost, signal, self, server})
  end
  
  # # @doc """
  # # #todo: Kill a `signal` already in Nubspace.
  # # """
  # # def kill!(signal) do
  # #   IO.inspect "#todo: add kill switch"
  # #
  # #   signal
  # # end
  #
  # ## Uploads
  
  def handle_cast({:upload, signal, program, server}, opts) do
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)
    
    signals = ILM.SignalSupervisor.signals
    signals = Dict.update(signals, signal.path, [server], fn signal_list -> List.flatten(signal_list, [server]) end)
    Application.put_env(:ilvmx, @castle_signals, signals)
    IO.inspect "(x-x-):SignalServer(:upload).signals {signals: #{inspect signals}}"

    upload_loop(signal_agent, program, server)

    {:noreply, opts}
  end
  
  def upload_loop(signal_agent, program \\ nil, server \\ nil) do
    IO.inspect "(x-x-):SignalServer.upload_loop{signal_agent: #{inspect signal_agent}, signal_server: #{inspect server}"

    receive do
      {:boost, boost_agent, client} ->
        # grab the two signals
        boost   = Agent.get boost_agent,  fn boost  -> boost end
        signal  = Agent.get signal_agent, fn signal -> signal end

        IO.inspect "(x-x-):SignalServer.upload_loop.boost:  #{inspect boost}"
        IO.inspect "(x-x-):SignalServer.upload_loop.signal: #{inspect signal}"
        
        #todo: exe program or otherwise pattern/match
        
        # "boost" the signal
        Agent.update(boost_agent,  fn signal -> Signal.i(boost, signal) end)
        Agent.update(signal_agent, fn signal -> Signal.i(signal, boost) end)

        send client, {:update, boost_agent, server}        
      {_, content} -> IO.inspect "(x-x-):unknown message in signal_loop: #{ inspect content }"
    end

    upload_loop(signal_agent, server)
  end
  
  ## Boosts
  
  def handle_cast({:boost, signal, client, server}, _nil) do
    IO.inspect "(x-x-):SignalServer.(boost) {signal: #{inspect signal.path}, server: #{inspect server} } "

    {:ok, boost_agent} = Agent.start_link(fn -> signal end)

    # collect signals
    #todo: add collect nil/all signals support
    ILM.SignalSupervisor.signals[signal.path] |> Enum.each fn server ->
      send server, {:boost, boost_agent, client} 
    end
    
    {:noreply, boost_loop(boost_agent, client, server)}
  end

  def boost_loop(boost_agent, client \\ nil, server \\ nil) do
    IO.inspect "(x-x-):SignalServer.boost_loop {agent: #{inspect boost_agent}, client: #{inspect client}, server: #{inspect server}}"

    receive do
      {:update, boost_agent, server} ->
        boost_loop(boost_agent, client, server)
    after
      3_000 -> boost_agent
    end
    
    Agent.get(boost_agent, fn signal -> signal end)
    |> ILM.Castle.CPU.Server.execute!
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Servers.Tower.commit!
  end
  
  ## GenServer
  
  def init(opts \\ nil) do
    {:ok, opts}
  end
  
  def start_link(opts \\ nil) do
    IO.inspect "(x-x-):SignalServer.start_link.self: #{inspect self} opts: #{inspect opts}"
    
    GenServer.start_link(__MODULE__, opts)
  end
  
end