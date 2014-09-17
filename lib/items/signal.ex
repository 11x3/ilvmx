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
  
  @doc "Make a `Signal`."
  def all(item \\ nil, source \\ nil) do
    set Castle.name, item, source
  end
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

