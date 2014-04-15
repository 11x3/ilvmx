defrecord Bot, 
  nubspace: nil,          # string    : "#some #app"
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil,
   cupcake: nil do        # callback
    
  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
  def w(args) do
    apply __MODULE__, :new, [Enum.concat(args, [unique: ILM.uuid])]
  end
  
  @doc """
  """
  def set(nubspace, cupcake) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub -> 
      ILM.Nubspace.push! bot.nubspace, cupcake
    end)
    |> ILM.BotLab.exe!
  end
  
  @doc """
  """
  def get(nubspace) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub ->
      ILM.Nubspace.pull! nubspace
    end)
    |> ILM.BotLab.exe!
  end
  
  @doc """
  Tell a Bot to exe a Cupcake app. Returns an Event you may capture to 
  be signaled of updates.
  """
  def exe(nubspace, cupcake \\ []) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub ->
      nub = get nubspace
      if is_function bot.cupcake do
        #bot.cupcake.(bot, nub)
      else
        nub.cupcake
      end
    end)
    |> ILM.BotLab.exe!
  end
  
  @doc """
  Signal a `nubspace` with `cupcake`
  """
  def sig(nubspace, cupcake) do
    Bot.w(nubspace: nubspace, cupcake: cupcake)
    |> ILM.Nubspace.beam!
  end
  
  @doc """
  Capture a Cupcake and evaluate command.
  """
  def cap(nubspace, cupcake) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: cupcake)
    |> ILM.Nubspace.beam!
  end

end