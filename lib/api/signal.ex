defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
              source: nil,  # sender (pid, email, nick, etc)
             content: nil,  # data/params
              unique: nil,  # uuid
             effects: []    # items

  @moduledoc """
  `Signal`s are the basic news unit of the ILvMx Galaxy.
  """
  
  @doc """
  Add an item/effect to a `Signal`.
  """
  def i(signal, items) do
    %{signal| :effects => List.flatten(signal.effects ++ [items]) }
  end
  
  @doc """
  Make a `Signal`.
  """
  def m(source, path \\ ILM.Castle.name, content \\ %{}) do
    %Signal{
          path: path,
        unique: ILM.Castle.uuid,
        source: source,
       content: content
    }
  end
  
  @doc """
  Execute a `Signal`.
  """
  def x(source, path, content \\ nil) do
    #todo: register with the Signal.Server
    m(source, path, content) |> ILM.Castle.gate!
  end
  
  @doc """
  Upload a `Signal`.
  """
  def u(source, path, content \\ nil) do
    #todo: register with the Signal.Server
    m(source, path, content) |> ILM.Castle.Signal.Server.upload!
  end
end

