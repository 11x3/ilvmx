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
    Castle.signal.item
  end
  
  @doc "Publish a `Signal` to the Game rules."
  def host!(signal) do
    #todo: validate signal
    signal_map = Dict.update(Castle.map, signal.set, [signal], fn signals -> [signal|signals] end)
    
    Application.put_env :ilvmx, :signal, %Signal{Castle.signal| item: signal_map, items: [signal|Castle.signal.items]}

    signal
  end
  
  @doc "Remove a `Signal` from the Game map."
  def kick!(signal) do
    #Application.put_env :ilvmx, :signal,
    
    signal
  end
  
  @doc "Run `signal` through the Castle.Game."
  def run!(signal, items \\ Castle.signal.items) do
    Logger.debug "Castle.Game.run!/signal: #{inspect signal}"
    
    # oh yeah, we're going to hit them all unless you say so...
    Castle.CPU.execute!(signal, items)
  end
  
  @doc "Move `signal` to primitives."
  def next?(signal) do
    
    signal
  end
  
  ## +++
  ## END
    
  ## GenServer Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

end