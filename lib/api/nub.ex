defmodule Nub do
  defstruct galaxy: nil,  # [:ilvmx]
            castle: nil,  # [:server, :cluster, :etc]
            unique: nil,  
            domain: nil,  # :api  # system        "lolnub.com"
            system: nil,  # :api  # subsys        :http
            module: nil,  # :api  # module        "support"
            member: nil,  # :api  # function      "search"
            method: nil,  # :api  # etc           "advanced"
           effects: []    # :data # args          "words"
  
  @doc """
  Create and fill a Nub from a ILVMX.Nubspace.Server.
  """
  def w(nubspace) do
    segments = nubspace |> String.split " "
    
    nub = %Nub{
      unique: ILVMX.Castle.Server.uuid,
      galaxy: ILVMX.Castle.Server.galaxy,
      castle: ILVMX.Castle.Server.name,  # "#lolnub" top level namespace
    }
    
    if length(segments) > 0 do
      nub = %{nub| domain: Enum.at(segments, 0) }
    end
    if length(segments) > 1 do
      nub = %{nub| domain: Enum.at(segments, 1) }
    end
    if length(segments) > 2 do
      nub = %{nub| domain: Enum.at(segments, 2) }
    end
    if length(segments) > 3 do
      nub = %{nub| domain: Enum.at(segments, 3) }
    end
    if length(segments) > 4 do
      nub = %{nub| domain: Enum.at(segments, 4) }
    end
    
    nub
  end
end