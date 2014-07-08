defmodule Signal do
  defstruct     path: "/",  # "about/ilvmx"
             content: nil,  # data/params
              source: nil,  # sender (pid, email, nick, etc)
              unique: nil,  # uuid
             effects: []    # items

  @moduledoc """
  `Signal`s are the basic news unit of the ILvMx Galaxy.
  """

  @doc """
  Signal.
  """
  def m(source), do: m(source, "/")
  def m(source, path, content \\ nil) do
    %Signal{
          path: path,
        unique: ILM.Castle.uuid,
        source: source,
       content: content
    }
  end
  def mx(source, path, content \\ nil) do
    m(source, path, content) |> ILM.Castle.gate!
  end
  
  @doc """
  Add an item/effect to a `Signal`.
  """
  def x(signal, items) do
    %{ signal| :effects => List.flatten [signal.effects, items] }
  end
end
