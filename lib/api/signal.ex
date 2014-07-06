defmodule Signal do
  defstruct   signal: nil,
             content: nil,
              source: nil,
              unique: nil,
             program: nil,
             effects: []

  @moduledoc """
  `Signal`s are the basic news unit of our ILM Kingdom.
  """
  def w(source, signal, content \\ nil) do
    %Signal{
        unique: ILM.Castle.uuid,
        signal: signal,
        source: source,
        content: content
    }
  end
end
