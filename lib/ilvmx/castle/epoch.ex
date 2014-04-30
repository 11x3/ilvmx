defmodule ILM.Epoch do
  use GenServer.Behaviour
  
  # API
  
  def tick(_) do
    :timer.sleep(10)
    
    ILM.Tower.signal! Event.w "tick"
    
    tick(nil)
  end
  
  # GenServer Callbacks

  def start_link do
    spawn __MODULE__, :tick, [[]]
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end