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
  
  # @doc "Collect signals from Castle."
  # def boost!(signal) do
  #
  #   # promote the signal to a GenServer
  #   {:ok, signal_server} = GenServer.start_link(__MODULE__, nil, debug: [])
  #
  #   IO.inspect "(x-x-):SignalServer.boost! {#{ inspect signal_server }, #{ inspect signal.path }} "
  #
  #   # process the signal/program,
  #   # then continue exe `after` a short timeout
  #   GenServer.cast(signal_server, {:boost, signal, signal_server})
  #
  #   signal
  # end
  #
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
  #   IO.inspect "(x-x-):SignalServer.upload_loop{signal_agent: #{inspect signal_agent}, signal_server: #{inspect server}"
  #
  #   receive do
  #     {:boost, booster_agent} ->
  #       # grab the two signals
  #       booster = Agent.get booster_agent, fn booster -> booster end
  #       signal = Agent.get  signal_agent, fn signal -> signal end
  #
  #       IO.inspect "(x-x-):SignalServer.upload_loop.booster: #{inspect booster}"
  #       IO.inspect "(x-x-):SignalServer.upload_loop.signal: #{inspect signal}"
  #
  #       if signal.path == booster.path do
  #         send signal.source, {:signal, signal}
  #         send booster.source, {:items, [signal], server}
  #         IO.inspect "(x-x-):SignalServer.send.signal: #{inspect signal.path}"
  #       end
  #     {_, content} -> IO.inspect "(x-x-):unknown message in signal_loop: #{ inspect content }"
  #   end
  #
  #   upload_loop(signal_agent, server)
  end
  #
  # ## Boosts
  #
  # def handle_cast({:boost, signal, client}, _nil) do
  #   IO.inspect "(x-x-):SignalServer.handle_cast :boost {client: #{inspect client},
  #   signal: #{inspect signal.path}, source: #{inspect signal.source} } "
  #
  #   {:ok, signal_agent} = Agent.start_link(fn -> signal end)
  #
  #   IO.inspect "(x-x-):SignalServer.handle_cast :boost {signals: #{inspect signals}}"
  #
  #   # collect signals
  #   #Task.async(fn ->
  #     signals |> Enum.each(fn server ->
  #       IO.inspect "(x-x-):send(#{inspect server}"
  #
  #       send(server, {:boost, signal_agent, client})
  #     end)
  #     #end)
  #
  #   {:noreply, boost_loop(signal_agent, client)}
  # end
  #
  # def boost_loop(signal_agent, client \\ nil) do
  #   IO.inspect "(x-x-):SignalServer.boost_loop {agent: #{inspect signal_agent}, client: #{inspect client}} "
  #
  #   receive do
  #     {:items, items, signal_server} ->
  #       Agent.update(signal_agent, fn signal -> signal = Signal.i(signal, items) end)
  #
  #       boost_loop(signal_agent, signal_server)
  #   after
  #     5_000 -> signal_agent
  #   end
  #
  #   signal = Agent.get(signal_agent, fn signal -> signal end)
  #   |> ILM.Castle.CPU.Server.execute!
  #   |> ILM.Castle.Wizard.Server.filter?
  #   |> ILM.Servers.Tower.commit!
  # end
  #
  # ## Capture
  #
  
  ## GenServer
  
  def init(opts \\ nil) do
    {:ok, opts}
  end
  
  def start_link(opts \\ nil) do
    IO.inspect "(x-x-):SignalServer.start_link.self: #{inspect self} opts: #{inspect opts}"
    
    GenServer.start_link(__MODULE__, opts)
  end
  
end