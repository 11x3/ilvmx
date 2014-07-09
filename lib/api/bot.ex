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

  
  # ## `Signal` API (routing)

  @doc """
  Get a `Signal.path` (ie. nubspace meta file) from this Castle.
  """
  def cap(signal, item \\ nil) do
    #todo: list items in /nub/
    
    # defstruct   kind: nil,  # mime/type
    #           unique: nil,  # "32453-4544-3434-234324-7879"
    #           object: nil,  # %{} => "/obj/32453/meta"
    #           binary: nil   # ""  => "/obj/32453/4544-3434-234324-7879"
    # todo: Wizard.valid_path?(nubspace)
    
    # read the nub/meta file
    signal_path = "nub/#{ signal.path }/meta"
    
    # use signal.path property for the valid_path? call,
    # then use the already assembled signal_path var for
    # the effect calls
    unless Wizard.valid_path?(signal.path) and File.exists?(signal_path) do
      Effect.w(signal_path, 404)
    else
      Effect.w(signal_path, prop(signal_path))
    end
  end
      
  # @doc """
  # """
  # def sig(nubspace, item) do
  # end

  
  ## `Item` + item.properties API
      
  # @doc """
  # Set per `Signal` key/values
  # """
  # def set(nubspace, key, value) do
  # end
  
  # @doc """
  # Get per `Signal` key/values
  # """
  # def get(nubspace, key \\ nil) do
  # end

  
  ## File API
  
  @doc """
  Take files from priv/static.
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
    
end