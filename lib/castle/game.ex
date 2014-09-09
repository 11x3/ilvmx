require Logger

defmodule Castle.Game do
  use GenServer
  use Jazz

  @moduledoc """
  Our Game server (or :emit stage) is where the app produces 
  most of the outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.

  # todo: add config support
  """
  
  ## SPECIAL
  ## +++++++
  ##
  ## Our feature presentation.
  
  @doc "Our Castle.Game map (handy item)."
  def map do
    Castle.signal.let
  end
  
  @doc "Run `signal` through the Castle.Game."
  def run!(signal, items \\ Castle.signal.items) do
    Logger.debug ".x.x.Castle.Game.run!/signal: #{inspect signal}"
    
    # oh yeah, we're going to hit them all unless you say so...
    signal = Castle.CPU.execute!(signal, items)
    |> next?
  end

  @doc "Publish a `Signal` to the Game rules."
  def host!(signal) do
    #todo: validate signal
    signal_map = Dict.update(Castle.map, signal.path, [signal], fn signals -> [signal|signals] end)
    
    Application.put_env :ilvmx, :signal, %Signal{Castle.signal| let: signal_map, items: [signal|Castle.signal.items]}

    signal
  end
  
  @doc "Remove a `Signal` from the Game map."
  def kick!(signal) do
    #Application.put_env :ilvmx, :signal,
    
    signal
  end
  
  @doc "Move `signal` to primitives."
  def next?(signal) do
    signal
    |> Castle.Wizard.filter?
    |> ping!
    |> pipe!
    |> galaxy!
    |> archive!
    
    signal
  end
  
  ## +++
  ## END
    
  ## Signals/Pipes/Networks aka Distribution.
  
  #todo: register/forward observers
    
  @doc "#todo: forward sequentially to all ping! observers."
  def ping!(signal) do
    #Castle.Game.cast! "#{signal.unique}/commit"
    
    signal
  end

  @doc "#todo: Send `signal` to external configured pipelines."
  def pipe!(signal) do
    
    signal
  end

  @doc "Save `signal` to disk as configured."
  def archive!(signal) do
    # todo: add/update commit times of signal
    
    signal
  end

  @doc "#todo: Share signals with the galaxy."
  def galaxy!(signal) do

    signal
  end


  ## GenServer Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

end