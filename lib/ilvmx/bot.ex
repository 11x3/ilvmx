defmodule Bot do
  defstruct unique: nil

  @moduledoc """
  Bots work on items inside the ILvMx universe.
  """


  ## World API (external items)

  @doc "Read a file from the internet."
  def web(path) do
    if Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Item API
  

  
  ## File API
  
  @doc "Take files from priv/static."
  def prop(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end

  @doc "Place objects into The World, oh our dear World."
  def drop(data, static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) do
      nil
    else
      File.write!(prop_path, data)
      
      data
    end
  end
  
  
  ## Private
  
  def nub_path(nubspace),  do: Path.join("/api/obj", String.lstrip(nubspace, ?#))
  
end