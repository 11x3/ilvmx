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
  Make `Signal`s.
  """
  def m(source),                      do: m(source, "/")
  def m(source, path, content \\ nil) do
    %Signal{
          path: path,
        unique: ILM.Castle.uuid,
        source: source,
       content: content
    }  
  end
  
  @doc """
  Add an item/effect to a `Signal`.
  """
  def x(signal, item) do
    %{signal| :effects => List.flatten(Enum.concat(signal.effects, [item])) }
  end
end
