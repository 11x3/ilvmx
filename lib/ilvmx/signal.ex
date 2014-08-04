defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
                item: nil,  # data/params
               items: [],   # [item] 
              source: nil,  # sender (pid, email, nick, etc)  
              unique: nil,  # uuid
               owner: nil   # Player
  
  @moduledoc """
  `Signal`s are the superglue unit of the ILvMx Galaxy.
  """
  
    
  ## API
  
  @doc "Make a `Signal`."
  def m(source, path \\ Castle.name, data \\ nil) do
    if data do
      item = Item.m data
    end
    
    %Signal{
          path: path,
          item: item,
         items: [],
        source: source,
        unique: Castle.uuid,
         owner: Player.anon!
    }
  end
  
  @doc "Install a Signal from an optional `source` at `path` with `item`."
  def i(path, item) when is_function(item) do
    i(nil, path, Program.cmd(item))
  end
  def i(path, item) do
    i(nil, path, item)
  end
  def i(source, path, item = %Program{}) do
    i(source, path, item) |> Castle.Wizard.please? |> Castle.CPU.capture!
  end
  def i(source, path, item) do
    #todo: uploads should go through the gate
    m(source, path, item) |> Castle.Wizard.please? |> Castle.CPU.install!
  end

  @doc "Execute a `Signal` `path` with optional `data`."
  def x(source, path, item \\ nil) do
    m(source, path, item) |> Castle.Wizard.please? |> Castle.CPU.execute!
  end
  
  
  ## Instance
  
  @doc "Add `items` to `signal`."
  def a(signal, items) when is_list(items) do
    %{signal| :items => List.flatten([signal.items|items]) }
  end
  def a(signal, item) do
    %{signal| :items => List.flatten([signal.items|[item]]) }
  end
  
end

