defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
             content: nil,  # data/params
              source: nil,  # sender (pid, email, nick, etc)
              unique: nil,  # uuid
               items: nil,
                 tmp: nil  # tmp or private stuff

  use GenEvent
               
  @moduledoc """
  `Signal`s are the basic news unit of the ILvMx Galaxy.
  """
  
  @doc """
  Make a `Signal`.
  """
  def m(source, path \\ ILM.Castle.name, content \\ nil) do
    %Signal{
          path: path,
       content: content,
        source: source,
        unique: ILM.Castle.uuid,
         items: [],
           tmp: %{}
    }
  end
  
  @doc """
  Upload a `Signal`.
  """
  def u(path, content) do
    u(nil, path, content)
  end
  def u(source, path, content) do
    #todo: uploads should go through the gate
    m(source, path, content) |> ILM.SignalServer.upload!
  end
  
  @doc """
  Execute a `Signal`.
  """
  def x(source, path, content \\ nil, program \\ nil) do
    #m(source, path, content) |> ILM.Castle.gate! |> ILM.Servers.Tower.capture!
  end
  
  @doc "Add `items` to `signal`."
  def i(signal, items) do
    %{signal| :items => List.flatten(signal.items ++ [items]) }
  end
end

