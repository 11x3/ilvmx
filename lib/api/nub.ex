defrecord Nub,
  galaxy: nil,    # [:ilvmx]
  castle: nil,    # [:server, :cluster, :etc]
  unique: nil,
  domain: nil,    # :api  # system        "lolnub.com"
  system: nil,    # :api  # subsys        :http
  module: nil,    # :api  # module        "support"
  member: nil,    # :api  # function      "search"
  method: nil,    # :api  # etc           "advanced"
nubcakes: []   do # :data # args          "words"
  
  @doc """
  Create and fill a Nub from a Nubspace.
  """
  def w(nubspace) do
    segments = nubspace |> String.split " "
    
    args = [
      unique: Castle.uuid,
      galaxy: Castle.galaxy,
      castle: Castle.door,  # "#lolnub" top level namespace
    ]
    
    if length(segments) > 0 do
      args = Enum.concat(args, [domain: Enum.at(segments, 0)])
    end
    if length(segments) > 1 do
      args = Enum.concat(args, [system: Enum.at(segments, 1)])
    end
    if length(segments) > 2 do
      args = Enum.concat(args, [module: Enum.at(segments, 2)])
    end
    if length(segments) > 3 do
      args = Enum.concat(args, [member: Enum.at(segments, 3)])
    end
    if length(segments) > 4 do
      args = Enum.concat(args, [method: Enum.at(segments, 4)])
    end
    
    Nub.new(args)
  end
end