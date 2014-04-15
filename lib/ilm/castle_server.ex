defmodule ILM.Castle.Server do
  use GenServer.Behaviour

  @doc """
  Send a Cupcake into the Castle and an Event back to capture or ignore.
  # Spawn |> Event[unique: uuid] 
  """
  def arrow!(cupcake) do
    
  end

  
  @doc """
  Send a Cupcake message into the Castle and wait for the results.
  Spawn |> Wait |> Bot
  """
  def dove!(bot) do
    
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end