defmodule ILM.Emit do
  
  @moduledoc """
  Emit is where our apps produce most of their outside world side effects from 
  events generated during the :transform stage.
  
  Examples events would include:
  - update :mesh adapters, inner ring, and signals
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
  def signal!(unique, event) do
  end
  
  @doc """
  Capture on the Bot's properties.
  """
  def capture!(unique) do
  end
  
  @doc """
  Bot close or commit the Bot to the Galactic record.
  """
  def commit!(bot) do
    ILM.EmitServer.commit! bot
  end

end
