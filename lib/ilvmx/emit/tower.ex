defmodule ILM.Tower do
  use GenServer.Behaviour
  
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
  
  alias Nubcake
  
  @signals  :signals
  
  
  # Public
  
  @doc """
  Return all signals in the Castle Nubspace.  
  """
  def signals do
    n = ConCache.get_or_store ILM.cache, @signals, fn -> 
      []
    end
  end

  @doc """
  Signal the Nubspace on `channel` with `event`.
  
  Return an Effect.w source: self, content: number of signals.
  """
  def signal!(channel, event) do
    signals |> Enum.each fn [channel: signal, callback: callback] ->
      if signal == channel do        
        callback.(event)
      end
    end
    
    Effect.w self, signals: signals
  end
  
  @doc """
  Capture on `channel` and exe `event_callback`.
  
  Return an Event.w source: self, content: channel
  
  # todo: convert event_callback to support Nubcake.
  """
  def capture!(channel, event_callback) when is_function event_callback do
    ConCache.put ILM.cache, @signals, Enum.concat(signals, [[channel: channel, callback: event_callback]])
    
    Event.w self, channel: channel
  end
    
  
  # GenServer Callbacks
  
  def start_link do
    ConCache.put ILM.cache, @signals, []
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end