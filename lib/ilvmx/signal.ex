defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
                item: nil,  # data/params
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil   # uuid

  use GenEvent
           
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.
  """

  @doc "Upload a `Signal`."
  def u(path, item) do
    u(nil, path, item)
  end
  def u(source, path, item) do
    #todo: uploads should go through the gate
    m(source, path, item) |> ILM.Nubspace.upload!
  end
  
  @doc "Make a `Signal`."
  def m(source, path \\ ILM.Castle.name, item \\ nil) do
    if item do
      item = Bot.set(item)
    end
    
    %Signal{
          path: path,
          item: item,
         items: [],
        source: source,
        unique: ILM.Castle.uuid
    }
  end
  
  @doc "Boost and capture a `Signal`."
  def x(source, path, item \\ nil) do
    m(source, path, item) |> ILM.Castle.gate!
  end
  
  # @doc "Capture a signal_path and message the source."
  # def c(source, path) do
  #   m(source, path) |> ILM.Servers.Tower.capture!
  # end
  
  @doc "Add `items` to `signal`."
  def i(signal, items) do
    %{signal| :items => List.flatten(signal.items ++ [items]) }
  end
  
end

