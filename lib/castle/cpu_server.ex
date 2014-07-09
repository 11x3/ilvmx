defmodule ILM.Castle.CPU.Server do
  use GenServer
  
  
  
  @programs %{}

  @doc """
  Process a `Signal` and emit `Effect`s.
  """
  def execute!(signal) do
    
    signal
  end
  def execute!(signal, []) do
    
    signal
  end
  def execute!(signal, program) do
    IO.inspect program
    
    #todo: exe program.code |> bot
    #todo: return signal + effects
  
    # Signal.e signal, Bot.cap(signal)
    # def m(source, path \\ ILM.Castle.name, content \\ %{}) do
    
    Signal.m self(), program.source, program.data
  end
  
  
  
  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
