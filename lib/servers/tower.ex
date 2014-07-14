defmodule ILM.Servers.Tower do
  use GenServer
  use Jazz

  @moduledoc """
  Our ILM.Servers.Tower (or :emit stage) is where our apps produce 
  most of their outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.
  """

  @doc """
  #todo: Register external clients for Signals
  """
  def capture!(signal) do
    # upload a program to exe on this signal
    # ILM.SignalServer.upload! signal, fn signal ->
    #   IO.inspect "(x-xILM.Servers.Towerower.capture! #{ inspect signal }"
    # end
    
    signal
  end

  @doc "commit the event"
  def commit!(signal) do
    # todo: start or broadcast/search for an existing signal_server
    # if signal.source do
    #   send signal.source, {:signal, signal}
    # end
    #
    signal
    |> signal!
  end
  
  @doc """
  Commit `signal` to Galaxy state.
  """
  def signal!(signal) do
    signal
    |> pipe!
    |> archive!
    |> galaxy!
  end

  @doc """
  #todo: Send `signal` to external configured pipelines.
  """
  def pipe!(signal) do
    
    signal
  end

  @doc """
  #todo: Save `signal` to disk as configured.
  """
  def archive!(signal) do
    # todo: add/update commit times of signal
    Item.object(Item.m, signal)
    
    signal
  end

  @doc """
  #todo: Share signals with the galaxy.
  """
  def galaxy!(signal) do
    
    signal
  end
  
    
  ## GenServer Callbacks
  
  def start_link do    
    GenServer.start_link(__MODULE__, nil)
  end
end