defmodule Castle.Game do
  use GenServer
  use Jazz

  @moduledoc """
  Our Game server (or :emit stage) is where the app produces 
  most of the outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.

  # todo: add config support
  """

  
  ## Players

  @doc "Publish a `Signal` to the Game rules."
  def on!(signal) do
    
  end
  
  @doc "#todo: Send a command to the arcade."
  def on?(player, command \\ nil, item \\ nil) do
    Player.items Player.start, Castle.ping!(Signal.m(command, item))
  end


  ## Signals/Pipes/Networks aka Distribution.
  
  @doc "Commit `signal` to Galaxy state."
  def commit!(signal) do
    signal
    |> Castle.Wizard.filter?
    |> ping!
    |> pipe!
    |> archive!
    |> galaxy!
  end
    
  @doc "#todo: forward sequentially to all ping! observers."
  def ping!(signal) do
    #todo: register/forward observers
    
    signal
  end

  @doc "#todo: Send `signal` to external configured pipelines."
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