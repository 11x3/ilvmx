defmodule ILM.Emit do
  @moduledoc """
  Emit is where our apps produce most of the outside world side effects from 
  events generated during the :transform stage.
  
  Examples events would include:
  - update :mesh adapters, inner ring, and connected observers
  - the file system with :json
  - web hooks with :hook

  # todo: add :query request processing.. so check each Emit call and make
  sure the spell is not a query before actually emitting anything other
  than Events.
    
  # todo: since every Request.callback invocation produces results into
  # Script.results list, it's really like an unordered list, and our Emit
  # and Event methods just match through the list for map/reduce style events.
  """

  @doc """
  Begin signaling on the Bot's properties.
  """
  def signal!(bot) do
    ILM.EmitServer.signal! bot
  end
  
  
  @doc """
  Register `observer` for direct event callbacks.
  """
  def mesh_with(observer) do
    ILM.EmitServer.mesh observer
  end
  
  @doc """
  Return list of `meshes` observers that receive direct event callbacks.
  """
  def meshes do
    ILM.EmitServer.meshes
  end
  
  @doc """
  Emit an event to outer ring observers. These will be app native processes. 
  
  Send the event to all registered observers, this is where adapters, or 
  Meteor or our own client side framework could mesh to an ILM server for
  high speed and real-time events, in whatever protocol of desire, of course.
  """
  def mesh(events) when is_list(events) do
    events |> Enum.each fn e -> mesh e end    
  end
  def mesh(event) do    
    event |> ILM.EmitServer.mesh! meshes
  end

end
