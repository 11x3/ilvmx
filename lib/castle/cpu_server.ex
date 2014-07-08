defmodule ILM.Castle.CPU.Server do
  use GenServer
  
  @programs %{}

  @doc """
  Process a `Signal` and emit `Effect`s.
  """
  def process!(signal) do
    # start or search for a signal_server

    signal
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Castle.Tower.Server.commit!
  end

  ## GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end
