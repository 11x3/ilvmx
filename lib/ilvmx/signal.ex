defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
                item: nil,  # data/params
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil,  # uuid
               owner: nil   # Player
  
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.
  
  Some things:
  - signals are the core MESSAGE unit of the Kingdom.
  - functions in `Signal` should NOT *directly* graph to disk (memory only)
  """
  
  @doc "Make a `Signal`."
  def m(source, path \\ ILM.Castle.name, data \\ nil) do
    if data do
      item = Item.m data
    end
    
    %Signal{
          path: path,
          item: item,
         items: [],
        source: source,
        unique: ILM.Castle.uuid,
         owner: Player.anon!
    }
  end
  
  
  ## API
  
  @doc "Install a Signal from an optional `source`, with `data` to `path`."
  def i(path, data) do
    i(nil, path, data)
  end
  def i(source, path, data) do
    #todo: uploads should go through the gate
    m(source, path, data) |> ILM.CPU.install!
  end

  @doc "Execute a `Signal` `path` with optional `data`."
  def x(source, path, data \\ nil) do
    m(source, path, data) |> ILM.Castle.please?
  end
  
  
  ## Instance
  
  @doc "Add `items` to `signal`."
  def a(signal, items) do
    %{signal| :items => List.flatten(signal.items ++ [items]) }
  end
  
end

