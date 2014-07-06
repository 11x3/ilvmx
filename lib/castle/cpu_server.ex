defmodule ILM.Castle.CPU.Server do
  use GenServer

  @doc """
  Submit an Signal to be processed.
  """
  def process!(signal) do
    # todo: exe the event.program
  end
  
  
  ## GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end