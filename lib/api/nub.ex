defmodule Nub do
  defstruct galaxy: nil,  # :ilvmx                network
            castle: nil,  # :server               server
            domain: nil,  # :api  # system        "#lolnub"
            system: nil,  # :api  # subsys        "#about"
            module: nil,  # :api  # module        "#support"
            member: nil,  # :api  # function      "#search"
            method: nil,  # :api  # etc           "#advanced"
            unique: nil,  # :api  # UUID          :uuid
           effects: []    # :data # args          
           
  @doc """
  Create a Nubspace.
  """
  def w(nubspace) do
    segments = nubspace |> String.split " "
    
    nub = %Nub{
      unique: ILM.Castle.Server.uuid,
      galaxy: ILM.Castle.Server.galaxy,
      castle: ILM.Castle.Server.name,  # "#lolnub" top level namespace
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
  
  def push!(nubspace, item) do
    ILM.Nub.Server.push!(nubspace, item)
  end
  
  def pull!(nubspace) do
    ILM.Nub.Server.pull!(nubspace)
  end

end