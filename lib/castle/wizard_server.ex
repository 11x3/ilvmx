defmodule ILVMX.Castle.Wizard.Server do
  use GenServer.Behaviour
  
  @doc """
  Submit an Event to the inner Castle.
  """
  def please?(event) do
    event 
    |> filter! 
    |> enrich! 
    |> shape! 
    |> ILVMX.Castle.CPU.Server.schedule!
  end
  
  @doc """
  Stub event filters.
  """
  def filter!(event) do
    # todo: add callbacks api
    
    event
  end
  
  @doc """
  Stub event enrichment.
  """
  def enrich!(event) do
    # todo: add callbacks api
    
    event
  end
  
  @doc """
  Stub event traffic flow.
  """
  def shape!(event) do
    # todo: add callbacks api
    
    event
  end
  
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end