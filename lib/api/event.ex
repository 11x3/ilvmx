defmodule Event do
  defstruct content:  nil,
            source:   nil,
            unique:   nil
  
  @moduledoc """
  The basic news unit of ILVMX. (ie. 1 request = n events).
  
  Events package a `source` of the event and unspecified `content`. Like Xmas 
  for whoever codes these.  
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
  and then pushing it to the network, where the effects may be seen 
  (including all results, errors, notes, etc.) from the :emit stage.
  """
  
  @doc """
  Create an "anonymous event".
  """
  def w(content) do
    w(nil, content)
  end
  
  @doc """
  Create a "source event".
  """
  def w(source, content) do
    %Event{
      content: content,
       source: source,
       unique: ILVMX.Castle.Server.uuid
    }
  end
  
end