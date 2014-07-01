defmodule ILM.Castle.Wizard.Server do
  use GenServer
  
  @doc """
  Submit an Event to the inner Castle.
  """
  def please?(event) do
    event 
    |> filter! 
    |> enrich! 
    |> shape!
    |> ILM.Castle.CPU.Server.submit!
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