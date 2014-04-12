defmodule ILM.BotLab do
  use GenServer.Behaviour
  use OtpDsl.Genserver
  
  alias ConCache
  alias ILM.Nubspace
  
  @moduledoc """
  BotLab is our ILM Bot WHQ and takes a request from the client or :adapt 
  stage of ATE and submits them to our :transform pipeline.
  
  Nubs stored in the Bots.script property are called in :transform and the
  results mapped and forwarded together to the next Nub in :script.
  
  When all Nubs have been executed (including scheduling future events etc),
  the Bot is passed from :transform to :emit where the individual :results are
  forwarded to the various areas of the app/net.
  """
  
  # API
  
  def exe(bot) do
    transform bot, bot.script
  end

  @doc """
  Not public yet.
  """
  def transform(bot, nil) do
    # todo: throw an Event that the Bot ran
    bot
  end
  def transform(bot, nubs) when is_list nubs do
    # transform each nub in the script
    transform(bot, hd nubs)
  end
  def transform(bot, nub) do    
    # call the bucket with the entire bot as the arg
    bot
  end
  
  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end