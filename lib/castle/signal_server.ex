defmodule ILM.SignalServer do
  use GenServer

  # Check and load custom castle scripts.
  @castle_signals   :castle_signals
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  ## Public
  @doc "Put `signal` into Nubspace."
  def upload!(signal) do
    {:ok, signal_server} = start_link(signal)
    
    # process the signal/program
    GenServer.cast(signal_server, {:upload, signal})

    # signal.content will now be this SignalServer
    %{signal| content: signal_server}
  end
  
  @doc "Collect signals from Castle."
  def boost!(signal) do
    # promote the signal to a GenServer
    {:ok, signal_server} = start_link(self)
    
    # signal.content will now be this SignalServer
    signal = %{signal| content: signal_server}
    
    # process the signal/program
    GenServer.cast(signal_server, {:boost, signal})
    
    receive do
      {:signal, signal} -> signal
    after
      5_000 -> signal
    end
    
    share!(signal)
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Castle.Tower.Server.signal!
  end
    
  @doc "Share a message with other SignalServers."
  def share!(signal) do

    signal
  end
  
  
  ## GenServer

  def start_link(signal_server \\ nil) do
    # # SignalServers listen for GenEvents between them.
    # {:ok, events} = GenEvent.start_link
    # GenEvent.add_handler(events, ILM.SignalServer, :share_event!, [])
    #
    GenServer.start_link(__MODULE__, signal_server)
  end
  
  def init(signal_server) do
    {:ok, signal_server}
  end

  def handle_cast({:boost, signal}, signal_server) do
    signal = signal |> ILM.Castle.CPU.Server.execute!
    send(signal.source, {:signal, signal})
    {:noreply, signal}
  end
  
  def handle_cast({:upload, signal}, signal_server) do
    IO.inspect "(x-x-).upload: #{ signal.path }"
    share_loop(signal)
    {:noreply, signal}
  end
  
  def share_loop(signal) do
    receive do
      {:share, shared_signal} -> GenServer.cast(self, {:boost, shared_signal})
    end
    
    share_loop(signal)
  end
  
  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal) do
  #   signal
  # end
  
end