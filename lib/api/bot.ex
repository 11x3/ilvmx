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
    ILVMX.Castle.Tower.Server.signal!(Event.w nubspace, item)
  end
  
  @doc """
  Capture a `nubspace` and evaluate `program` when signaled.
  """
  def cap(nubspace, program) do
    ILVMX.Castle.Tower.Server.capture!(nubspace, program)
  end
  
  
  ## Prop API (castle items)
  
  @doc """
  Take objects from The World, oh our dear World.
  # todo: secure the path, yes yes yes
  """
  def prop(nubspace) do
    # todo: secure path
    File.read! Path.join("priv/static", nubspace)
  end
  
  @doc """
  Place objects into The World, oh our dear World.
  """
  def drop(nubspace, item) do
    # todo: secure path
    File.write! Path.join("priv/static/api", nubspace), item
    
    item
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