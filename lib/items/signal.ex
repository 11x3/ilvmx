defmodule Signal do
  @derive [Enumerable]
  defstruct   path: nil,  # "about/ilvmx"
            source: nil,  # castle/program/etc
            unique: nil,  # uuid
              item: nil,  # item/request/upload/etc
             items: []    # [effects]
  
  @moduledoc """
  `Signal`s are the superglue unit of an ILvMx Galaxy.
  """
  
  ## API
  
  @doc "Make a catch all `Signal` at the root of Castle.Nubspace."
  def all(item \\ nil, source \\ nil) do
    set Castle.name, item, source
  end
  
  @doc "Make a `Signal` at `path` with optional `item` and `items` in Castle.Nubspace."
  def set(path, item \\ nil, items \\ nil) when is_binary(path) do
    %Signal{
          path: path,
        source: nil,
        unique: Castle.uuid,
          item: item,
         items: items || [],
    }
  end
  
  ## Instance
  
  @doc "Add `items` to `signal`."
  def boost(signal = %Signal{}, items) do
    put_in signal.items, List.flatten([items])
  end

end

