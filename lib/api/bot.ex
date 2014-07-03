import IT

defmodule Bot do
  defstruct program: nil,
             unique: nil
               
  @moduledoc """
  Bots are the basic workers of the ILvMx universe.
  """
  
  
  ## Nubspace API (disk items) 
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def set(nubspace, item) do
    Nub.push!(nubspace, item)
  end
  
  @doc """
  Get a `nub` from `nubspace`.  
  """
  def get(nubspace) do
    Nub.pull!(nubspace)
  end


  ## Signal API (memory items)
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def sig(nubspace, item) do
    ILM.Castle.Tower.Server.signal!(Event.w nubspace, item)
  end
  
  @doc """
  Capture a `nubspace` and evaluate `program` when signaled.
  """
  def cap(nubspace, program) do
    ILM.Castle.Tower.Server.capture!(nubspace, program)
  end
  
  
  ## Prop API (castle items)
  
  @doc """
  Take objects from The World, oh our dear World.
  """
  def prop(static_relative_path) do
    item_path = Path.join("priv/static", static_relative_path)
    unless IT.valid_path?(item_path) and File.exists?(item_path) do
      nil
    else
      File.read! item_path
    end
  end
  
  @doc """
  Place objects into The World, oh our dear World.
  """
  def drop(item) do
    obj_relative_path = "#{ ILM.Castle.Server.uuid }"

    item_path = Path.join("priv/static/api/obj", obj_relative_path)
    unless IT.valid_path?(item_path) do
      nil
    else
      item |> File.write! item_path
    end
  end
  
  @doc """
  List the objects of `nubspace`.
  """
  def list(api_relative_path) do
    
  end
  
  ## World API (external items)
  
  @doc """
  Read a file from the internet.
  # todo: secure the path, yes yes yes
  # todo: add web REST support
  """
  def web(path) do
    HTTPotion.get(path).body
  end
  
end