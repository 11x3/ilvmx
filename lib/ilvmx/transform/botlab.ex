defmodule ILM.BotLab do
  use GenServer.Behaviour
  
  @moduledoc """
  BotLab is our ILM Bot WHQ and takes a request from the client or :adapt 
  stage of ATE and submits them to our :transform pipeline.
  
  Cupcake DSLs stored in the Bots.script property are called in the :transform 
  and the effects mapped and forwarded together to the next cmd in :script.
  
  When all Nubs have been executed (including scheduling future events etc),
  the Bot is passed from :transform to :emit where the individual :effects are
  forwarded to the various areas of the app/network.
  """
  
  # Private

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end