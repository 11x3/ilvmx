defmodule ILM.WizardServer do
  use GenServer
  
  @doc """
  Ask the Wizard (nicely) to process a `Signal`.
  """
  def please?(signal) do
    signal |> review?
  end

  @doc """
  Stub :before `Signal` traffic flow control.
  """
  def review?(signal) do
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
    GenServer.start_link(__MODULE__, nil)
  end
end