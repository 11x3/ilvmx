defmodule ILM.Castle.CPU.Server do
  use GenServer
  
  @programs %{}

  @doc """
  Process a `Signal` and emit `Effect`s.
  """
  def execute!(signal) do
    Signal.e signal, Bot.cap(signal)
  end

  ## GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end
