defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
              source: nil,  # sender (pid, email, nick, etc)
             content: nil,  # data/params
              unique: nil,  # uuid
                 tmp: nil,  # tmp or private stuff
               items: []    # items

  use GenEvent
               
  @moduledoc """
  `Signal`s are the basic news unit of the ILvMx Galaxy.
  """
  
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
    m(source, path, content) |> ILM.Castle.gate!
  end
  
  @doc """
  Upload a `Signal`.
  """
  def u(path, content) do
    u(nil, path, content)
  end
  def u(source, path, content \\ nil) do
    m(source, path, content) |> ILM.SignalServer.upload!
  end
  
  @doc """
  Add an `Item` to a `Signal`.
  """
  def i(signal, items) do
    %{signal| :items => List.flatten(signal.items ++ [items]) }
  end
end

