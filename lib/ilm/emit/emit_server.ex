defmodule ILM.EmitServer do
  use GenServer.Behaviour
  
  @moduledoc """
  Emitters work in a two-step process. A lexical Emit.capture(channel) and
  an Emit.results(channel) which sends the given channel all of the events.
  
  # todo: add :query request processing.. so check each Emit call and make
  sure the spell is not a query before actually emitting anything other
  than Events.
  
  # todo: add an EmitServer to grind the emissions out.
  
  # todo: since every Request.callback invocation produces results into
  # Script.results list, it's really like an unordered list, and our Emit
  # and Event methods just match through the list fo
  """
  
  @doc """
  Begin meshing signals on `bot`.
  """
  def signal!(bot) do
    # todo
      
    bot
  end
  
  @doc """
  Emit an entire `Script` to the emitters and pipelines. Returns the complete
  `spell` where all results have been applied. Our ILM.castle is now completely
  done forward processing the spell.
  """
  def mesh!(spell) do
    # Let *EVERYONE* know this request has been committed. Which for anonymous
    # requests could mean nothing at all will follow, or for requests with
    # tranforms that emit things, could be the emission process has started
    # – either way, this is the official broadcast that this spell/request
    # has been dispatched.    

    Event.w spell, Result.w(:spell, :commit, :uuid, spell.uuid)
    
    spell.results |> Enum.each &(mesh_event!/1)
    
    # todo: spawn new workers to actually push the content to the emitters. We
    # spawn all of the internal emitters first because they are our bffs and, 
    # the pipeline may be slow, controlled, or go to hell all together and
    # we wouldn't cry too much – the core app will still be up.
    
    #spell.results |> Enum.map fn (event) -> event |> emitters! end
    #spell.results |> Enum.map fn (event) -> event |> pipelines! end
    
    spell
  end
  
  @doc """
  Return list of registered emitters.
  """
  def mesh_event!(event) do
    # spawn new workers to actually push the content to the emitter
    # todo: add a poolboy here
    [:mesh] |> Enum.each fn emitter ->
      #spawn ILM.Emit, emitter, event
    end
    
    event
  end
  
  @doc """
  Return list of registered pipelines.
  # todo: add a poolboy here
  """
  def pipelines!(event) do
    # [:static, :hook, :pipe] |> Enum.each fn emitter ->
    #   spawn ILM.Emit, emitter, [event]
    # end
  end
  
  def meshes_cache_tag do
    :emit_server_meshes
  end
  
  def meshes do
    meshes = ConCache.get ILM.cache, meshes_cache_tag
    if !meshes do
      meshes = []
      ConCache.put ILM.cache, meshes_cache_tag, meshes
    end
    meshes
  end
  
  def mesh(observer) do
    meshes = [meshes ++ observer]
    ConCache.put ILM.cache, meshes_cache_tag, meshes
    meshes
  end
  
  
  # GenServer Callbacks
  
  def start_link do
    ConCache.put ILM.cache, :emit_server_observers, []
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end