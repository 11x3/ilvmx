use Amnesia
use Db

defmodule ILvMx.Castle.Tower do
  use GenServer.Behaviour
  
  alias Program
  
  @signals  :signals
  
  @moduledoc """
  Emit is where our apps produce most of their outside world side effects from 
  events generated during the :transform stage.
  
  Examples events would include:
  - update :mesh adapters, inner ring, and signals
  - the file system with :json
  - web hooks with :hook

  # todo: since every Request.callback invocation produces results into
  # Script.results list, it's really like an unordered list, and our Emit
  # and Event methods just match through the list for map/reduce style events.
  
  Emitters work in a two-step process. A lexical Tower.capture(channel) and
  an Tower.results(channel) will send the given channel all of the events.
  
  # todo: store capture records for expiration purposes.
  """

  # Public
  
  @doc """
  Return all signals in the Castle ILvMx.Nubspace.  
  """
  def signals do
    n = ConCache.get_or_store ILvMx.cache, @signals, fn -> 
      []
    end
  end

  @doc """
  Signal the ILvMx.Nubspace on `channel` with `event`.
  
  Return an Effect.w source: self, content: number of signals.
  """
  def signal!(event, channel \\ nil) do
    signals |> Enum.each fn [channel: signal, callback: callback] ->
      if signal == channel do        
        callback.(event)
      end
    end
        
    # save to db
    Amnesia.transaction do
      Events[
        content: inspect(event.content), 
         source: inspect(event.source), 
         unique: inspect(event.unique)
      ].write
    end
    
    Effect.w self, signals: signals
  end
  
  @doc """
  Capture on `channel` and exe `event_callback`.
  
  Return an Event.w source: self, content: channel
  
  # todo: convert event_callback to support Program.
  """
  def capture!(channel, function) when is_function function do
    ConCache.put ILvMx.cache, @signals, Enum.concat(signals, [[channel: channel, callback: function]])
    
    Event.w self, channel: channel
  end
  
  # Private
    
  def tick(_) do
    :timer.sleep(1000)
    
    signal! Event.w "tick"
    
    tick(nil)
  end
  
  # GenServer Callbacks
  
  def start_link do
    ConCache.put ILvMx.cache, @signals, []
    
    spawn __MODULE__, :tick, [[]]
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end