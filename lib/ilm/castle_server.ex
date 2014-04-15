defmodule ILM.Castle.Server do
  use GenServer.Behaviour

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end