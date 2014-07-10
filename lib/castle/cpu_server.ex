defmodule ILM.Castle.CPU.Server do
  use GenServer




  def execute!(signal) do
    
    #todo: compile signal into program
    #todo: exe program.code |> bot
    #todo: return signal + effects
    
    signal
  end
  
  
  
  
  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
