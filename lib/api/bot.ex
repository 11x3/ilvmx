defmodule Bot do
  defstruct program: nil,
             unique: nil


  # Nubspace API
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def set(nubspace, item) do
    ILVMX.Nub.Server.push!(nubspace, item)
  end
  
  @doc """
  Get a `nub` from `nubspace`.  
  """
  def get(nubspace) do
    ILVMX.Nub.Server.pull!(nubspace)
  end
  
  @doc """
  Capture a `nubspace` and evaluate nubcake when signaled.
  
  Returns `bot`.
  """
  def cap(nubspace, program) do
    ILVMX.Castle.Tower.Server.capture!(nubspace, program)
  end
  
  
  # Prop API
  
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
    File.write! Path.join("priv/static", nubspace), item
    
    item
  end
  
  @doc """
  Read a file from the internet.
  # todo: secure the path, yes yes yes
  # todo: add web REST support
  """
  def web(path) do
    HTTPotion.get(path).body
  end
  
end