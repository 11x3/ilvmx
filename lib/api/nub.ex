defrecord Nub,
  galaxy: :ilm,   # [:ilm, :http]
  unique: nil,
  method: nil,    # :network
  castle: nil,    # [:server, :cluster, :etc]
  system: nil,    # :api  # system
  domain: nil,    # :api  # subsys
  module: nil,    # :api  # module
  member: nil,    # :api  # function
  bucket: []   do # :data # args

  def w(args \\ []) do
    apply __MODULE__, :new, [args ++ [unique: ILM.uuid]]
  end
  
end