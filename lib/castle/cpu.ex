defmodule Castle.CPU do
  use GenServer
  import Castle
  


  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
  end
  
  def handle_info(message, state) do
    {:reply, state}
  end

  def start_link(default \\ nil) do
    GenServer.start_link(Castle.CPU, default)
  end
end
