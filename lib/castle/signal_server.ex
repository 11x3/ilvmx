defmodule ILM.Castle.Signal.Server do
  use GenServer

  @signals :signals
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  def signal!(signal) do
    
    signal
  end
  
  def nub_path(nubspace),  do: Path.join("/obj", String.lstrip(nubspace, ?#))
   
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end