defmodule Services.Tower do
  use GenServer
  use Jazz

  @moduledoc """
  Our Tower server (or :emit stage) is where the app produces 
  most of the outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.
  
  # todo: add config support
  """


  @doc """
  #todo: Register external clients for Signals
  """
  def beam!(signal) do

    signal
  end


  @doc "Commit `signal` to Galaxy state."
  def commit!(signal) do    
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
  Save `signal` to disk as configured.
  """
  def archive!(signal) do
    # todo: add/update commit times of signal

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