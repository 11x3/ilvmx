defmodule Event do
  defstruct content:  nil,
            source:   nil,
            unique:   nil
  
  @moduledoc """
  The basic news unit of ILVMX.
  """
  
  @doc """
  Submit an `Event` to be exe immediately.
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