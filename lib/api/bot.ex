defrecord Bot, 
  nubspace: nil,          # string    : "#some #app"
   cupcake: nil,          # contents
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil do        # callback


  # API
  
  @doc """
  Store the `cupake` into the `nubspace`.
  """
  def set(nubspace, cupcake) do
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub -> 
      ILM.Nubspace.push! bot.nubspace, cupcake
      
      bot
    end)
    |> Castle.arrow!
  end
  
  @doc """
  Get a `Cupcake` from the `nubspace`.
  """
  def get(nubspace) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub ->
      ILM.Nubspace.pull! nubspace
    end)
    |> Castle.arrow!
  end
  
  @doc """
  Exe a Cupcake app. Returns an Event you may capture to 
  be signaled of updates.
  """
  def exe(nubspace, cupcake \\ []) do
    Bot.w(nubspace: nubspace, cupcake: fn bot, nub ->
      # Transform the bot in real-time, from this
      # fun to the fun originally passed into exe.
      ILM.Nubspace.jump! bot.cupcake(cupcake), nubspace
      
      bot
    end)
    |> Castle.arrow!
  end
  
  # @doc """
  # Signal a `nubspace` with `cupcake`
  # """
  # def sig(nubspace, cupcake) do
  #   Bot.w(nubspace: nubspace, cupcake: cupcake)
  #   |> ILM.Nubspace.beam!
  # end
  
  # @doc """
  # Capture a Cupcake and evaluate command.
  # """
  # def cap(nubspace, cupcake) do
  #   # set :commands and spawn
  #   Bot.w(nubspace: nubspace, cupcake: cupcake)
  #   |> ILM.Nubspace.beam!
  # end


  # Private
  
  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
  def w(args \\ []) do
    apply __MODULE__, :new, [Enum.concat(args, [unique: ILM.uuid])]
  end
end