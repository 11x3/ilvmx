use Jazz

defmodule ILVMX.Castle.Tower.Server do
  use GenServer.Behaviour
    
  @signals  :signals
  
  @moduledoc """
  Our ILVMX.Castle.Tower.Server (or :emit stage) is where our apps produce 
  most of their outside world side effects, which come from events that are 
  generated during the :adapt, and :transform stage of the app.
  """
  
  ## Effects
  
  @doc """
  Signal an `Event` or `Effect` to the world.
  """
  def signal!(event = %Event{}) do
    event.effects |> Enum.each &signal!/1
  end
  def signal!(effect) do
    signals |> Enum.each fn [signal: signal, program: program] ->
      if signal == effect.source do        
        program.(effect)
      end
    end
    
    effect
  end
  
  ## Signals
  
  @doc """
  Capture on `signal` and exe `program`.
  """
  def capture!(signal, program) when is_function(program) do
    ConCache.put ILVMX.Castle.Server.cache, @signals, Enum.concat(signals, [[signal: signal, program: program]])
    
    Effect.w self, signal: signal
  end
  
  ## Events
  
  @doc """
  Commit the Event to galaxy state.
  """
  def commit!(event) do
    event
    |> pipe!
    |> archive!
    |> galaxy!
  end
  
  @doc """
  Send the event to external pipelines.
  """
  def pipe!(event) do
    event
  end
  
  @doc """
  Save to disk.
  """
  def archive!(event) do
    # create nub + meta directory
    events = "priv/static/api/events"
    unless File.exists? events do
      File.mkdir! events
    end

    # check/create the metanub
    file = Path.join(events, event.unique)
        
    # todo: add/update commit times of event
    File.write!(file, JSON.encode!(event))
    
    event
  end

  @doc """
  Share "important" events with the galaxy.
  """
  def galaxy!(event) do
    event
  end
  
  ## Private
  
  @doc """
  Return all signals in the Castle ILVMX.Nub.Server.  
  """
  def signals do
    n = ConCache.get_or_store ILVMX.Castle.Server.cache, @signals, fn -> 
      []
    end
  end

  def tick(_) do
    :timer.sleep(1000)
    
    signal! Effect.w "tick"
    
    tick(nil)
  end
  
  
  ## GenServer Callbacks
  
  def start_link do
    ConCache.put ILVMX.Castle.Server.cache, @signals, []
    
    spawn __MODULE__, :tick, [[]]
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end