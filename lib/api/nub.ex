defrecord Nub,
  galaxy: nil,    # [:ilvmx]
  castle: nil,    # [:server, :cluster, :etc]
  unique: nil,
  domain: nil,    # :api  # system        "lolnub.com"
  system: nil,    # :api  # subsys        :http
  module: nil,    # :api  # module        "support"
  member: nil,    # :api  # function      "search"
  method: nil,    # :api  # etc           "advanced"
cupcakes: []   do # :data # args          "words"

  @doc """
  Shortcut to create a `Nub`.   
  """
  def w(args \\ []) do
    apply __MODULE__, :new, [args]
  end
end