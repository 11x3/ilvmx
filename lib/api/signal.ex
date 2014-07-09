defmodule Signal do
  defstruct     path: nil,  # "about/ilvmx"
             content: nil,  # data/params
              source: nil,  # sender (pid, email, nick, etc)
              unique: nil,  # uuid
             effects: []    # items

  @moduledoc """
  `Signal`s are the basic news unit of the ILvMx Galaxy.
  """
  
  @doc """
  Add an item/effect to a `Signal`.
  """
  def e(signal, items) do    
    %{signal| :effects => List.flatten(signal.effects ++ [items]) }
  end
  
  @doc """
  `m` make a `Signal`.
  """
  def m(source, path \\ ILM.Castle.name, content \\ nil) do
    %Signal{
          path: path,
        unique: ILM.Castle.uuid,
        source: source,
       content: content
    }
  end
  
  @doc """
  `x` execute a `Signal`.
  """
  def x(source, path, content \\ nil) do
    #todo: capture this signal  
    signal = Task.async(fn -> m(source, path, content) |> ILM.Castle.gate! end) |> Task.await
    
  end
end

