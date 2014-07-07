defmodule Bot do
  defstruct unique: nil

  @moduledoc """
  Bots work on items inside the ILvMx universe.
  """


  ## World API (external items)

  @doc """
  Read a file from the internet.
  """
  def web(path) do
    if Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end
    
  ## Item API
  ## For working with the binary properties of an `Item`

  @doc """
  Take objects from The World, oh our dear World.
  """
  def prop(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end

  @doc """
  Place objects into The World, oh our dear World.
  """
  def drop(static_relative_path, data) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Wizard.valid_path?(prop_path) do
      nil
    else
      File.write! prop_path, data
      
      data
    end
  end
  
  
  # ## Signal API (routing)
  # ## Routing-based methods
  #
  # @doc """
  # """
  # def sig(nubspace, item) do
  # end
  #
  # @doc """
  # """
  # def cap(nubspace, item) do
  # end
  
  
  # ## Nubspace API (Item.object)
  # ## For working with the object properties of an `Item`
  #
  # @doc """
  # """
  # def exe(nubspace) do
  # end
  #
  # @doc """
  # """
  # def set(nubspace, key, value) do
  # end
  #
  # @doc """
  # """
  # def get(nubspace, key \\ nil) do
  # end

end