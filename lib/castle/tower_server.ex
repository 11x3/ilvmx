defmodule ILM.Castle.Tower.Server do
  use GenServer
  use Jazz

  @moduledoc """
  Our ILM.Castle.Tower.Server (or :emit stage) is where our apps produce 
  most of their outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.
  """

  @doc """
  #todo: Register external clients for Signals
  """
  def capture!(signal) do
    # todo: start or broadcast/search for an existing signal_server
    
    signal
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
    # # create nub + meta directory
    # signals = "priv/static/obj/signals"
    # unless File.exists? signals do
    #   File.mkdir! signals
    # end
    #
    # # check/create the metanub
    # file = Path.join(signals, signal.unique)
    #
    # # todo: add/update commit times of signal
    # File.write!(file, JSON.encode!(signal))

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