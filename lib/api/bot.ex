defrecord Bot, 
   cupcake: nil,          # string    : "#some #app"
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil,
   command: nil do        # callback
    
  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
  def w(args) do
    apply __MODULE__, :new, [Enum.concat(args, [unique: ILM.uuid])]
  end
  
  @doc """
  Tell a Bot to exe a Cupcake script. Returns an Event you may capture to 
  be signaled of updates.
  """
  def set(cupcake, contents) do
    # set :commands and spawn
    Bot.w(cupcake: cupcake, command: fn bot, nub -> 
      ILM.Nubspace.push! bot.cupcake, contents
    end)
    |> ILM.BotLab.exe!
  end
  
  @doc """
  Tell a Bot to exe a Cupcake script. Returns an Event you may capture to 
  be signaled of updates.
  """
  def get(cupcake) do
    # set :commands and spawn
    Bot.w(cupcake: cupcake, command: fn bot, nub ->
      ILM.Nubspace.pull! cupcake
    end)
    |> ILM.BotLab.exe!
  end
  
  # @doc """
  # Tell a Bot to exe a Cupcake script. Returns an Event you may capture to 
  # be signaled of updates.
  # """
  # def exe(cupcake) do
  #   # set :commands and spawn
  #   Bot.w(cupcake: cupcake) |> ILM.BotLab.get!
  # end
  
  @doc """
  Easy method to check/return the first effect.
  """
  # def result(bot) do
  #   hd bot.results
  # end
  # 
  # def effects do
  #   # scan through results and "bring up" the Events
  # end
  
end