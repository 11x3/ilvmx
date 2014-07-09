defmodule Effect do
  defstruct  source: nil,
            message: nil,
            content: nil,
             unique: nil

  @moduledoc """
  Effect are side effects of Bots and other things happening. They are
  abstract recordings that something has, should, might, or will happen
  somewhere in the Castle.

  When `Signals` are dispatched the `Effects` are generated inside the
  :transform stage of our pipeline, as that's where primary compute lives.
  They are then broadcast to the Castle and Galaxy (along with other data)
  during the :emit stage pipeline.
  """
  def w(content), do: w(nil, content)
  def w(source, content) do
    #todo: add message
    %Effect{
       source: source,
      content: content,
       unique: ILM.Castle.uuid
    }
  end
end