defmodule ILVMX.Castle.Wizard.Server do
  use GenServer.Behaviour

  # Native
  
  @doc """
  #todo: filter/enrich/shape the event.
  """
  def please?(event) do
    Bot.exe(event) 
    |> ILVMX.Castle.CPU.Server.execute!
    |> ILVMX.Castle.Tower.Server.commit!
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end