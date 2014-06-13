defmodule ILVMX.Castle.CPU.Server do
  use GenServer

  @doc """
  Submit an Event to be processed.
  """
  
  def submit!(event) do
    # todo: exe the event.program
      
    %{ event | effects: [event.effects| Bot.get(event.program) ]}
  end
  
  
  # GenServer Callbacks
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end