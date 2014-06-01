defmodule Effect do
  defstruct  source: nil,
            content: nil,
             unique: nil

  @moduledoc """
  Effect are side effects of Bots and other things happening. They are 
  abstract recordings that something has, should, might, or will happen 
  somewhere in the Castle.

  When Nubs are dispatched `Events` and `Effects` are generated inside the 
  :transform stage of our pipeline, as that's where primary compute lives. 
  They are then broadcast to the Castle and Galaxy (along with other data)
  during the :emit stage pipeline.
  """
  def w(content), do: w(nil, content)
  def w(source, content) do
   %Effect{
       source: source,
      content: content,
       unique: ILVMX.Castle.Server.uuid
   }
  end 
end