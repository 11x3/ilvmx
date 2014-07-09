defmodule ILM.Castle.Signal.Server do
  use GenServer

  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  def capture!(signal) do
    #todo: start or broadcast/search for an existing signal_server
    #todo: store program

    signal
  end

  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end