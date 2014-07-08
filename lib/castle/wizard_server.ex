defmodule ILM.Castle.Wizard.Server do
  use GenServer
  
  @doc """
  Ask the Wizard (nicely) to process a `Signal`.
  """
  def please?(signal) do
    signal
    |> enrich?
    |> ILM.Castle.Signal.Server.signal!
  end

  @doc """
  Stub :before `Signal` traffic flow control.
  """
  def enrich?(signal) do
    # todo: add callbacks api

    signal
  end
  
  @doc """
  Stub :after `Signal` traffic filters.
  """
  def filter?(signal) do
    # todo: add callbacks api

    signal
  end

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end