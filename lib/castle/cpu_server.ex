defmodule ILM.Castle.CPU.Server do
  use GenServer

  def execute!(signal) do
    signal
  end
  def execute!(signal = %Signal{}, [effect|effects_tail]) do
    execute!(signal, effect)
    execute!(signal, effects_tail)
  end
  def execute!(signal = %Signal{}, program = %Program{}) do
    # compile programs inside signal.effects
    throw IO.inspect program
    
    signal
  end
  def execute!(signal = %Signal{}, effect) do
    
    effect
  end

  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
