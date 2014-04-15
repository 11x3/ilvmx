defrecord Nub,
  galaxy: nil,    # [:ilvmx]
  castle: nil,    # [:server, :cluster, :etc]
  unique: nil,
  domain: nil,    # :api  # system        "lolnub.com"
  system: nil,    # :api  # subsys        :http
  module: nil,    # :api  # module        "support"
  member: nil,    # :api  # function      "search"
  method: nil,    # :api  # etc           "advanced"
  bucket: []   do # :data # args          "words"

  def w(args \\ []) do
    apply __MODULE__, :new, [List.flatten([args ++ [unique: ILM.uuid]])]
  end
  
  def from(cupcake) do
    segments = cupcake |> String.split " "
    
    args = [
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
    # todo: add bucket storage
    # if length segments > 7 do
    #   #args = args[bucket: elem segments, 7]
    # end
    
    w(args)
  end

end