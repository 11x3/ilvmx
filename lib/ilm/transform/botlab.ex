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
  
  # Given this Bot request:
  #
  # Bot[
  #   cupcake: "#chat",
  #   effects: [],
  #   problems: [],
  #   accounts: [cash: [],
  #   karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
  #   unique: "50c2d34a-78b4-436c-a6ec-9891806e0e84",
  #   command: fun]
  # ]

  # and this nub:
  # Nub[
  #   galaxy: :ilvmx, 
  #   castle: "#lolnub", 
  #   unique: "c7b36851-01e9-47df-8c40-7322c6404376", 
  #   system: "#ilm", 
  #   domain: "#chat", 
  #   module: nil, 
  #   member: nil, 
  #   method: nil, 
  #   cupcake: []]
  # ]
  """

  @doc """
  Find, signal, and return a Nubspace.
  # todo: add signal to nubs.
  """
  def exe!(bot) do
    if is_function bot.cupcake do
      results = [bot.cupcake.(bot, [ILM.Nubspace.pull!(bot.nubspace)])]
      |> List.flatten
    else
      ILM.Nubspace.pull! bot.nubspace
    end
  end
  
  def sig!(bot) do
    
  end

  # Private

  # GenServer Callbacks

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end