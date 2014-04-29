defmodule Event do
  defstruct content:  nil,
            source:   nil,
            unique:   nil
  
  @moduledoc """
  The basic news unit of ILM. (ie. 1 request = n events) Events package 
  a `source` of the event and random content. Like Xmas for whoever 
  codes these.  
  ```
  event = [
    content = Result[ 
      Bot[:after, :pings, :create, nil], 
      [:emit, :json, :path, :content]
    ]
    source  = Bot[...]
  ]
  ```
  
  With an Event.source = Bot what we are doing is exe'ing the entire request
  and then slinging it right out to the network, where the effects may be
  seen (including all results, errors, notes, etc.) from the :emit stage.
  """
  
  @doc """
  Shortcut to create an `Event`.   
  """
  def w(content) do
    w(nil, content)
  end
  def w(source, content) do
    %Event{
      content: content,
       source: source,
       unique: Castle.uuid
    }
  end
end