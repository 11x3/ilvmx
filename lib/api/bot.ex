defrecord Bot, 
  nubspace: nil,          # string    : "#some #app"
   cupcake: nil,          # contents
   results: [],           
  problems: [],           # [error_events]
  accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil do        # callback

  # API
  
  @doc """
  Store `cupcake` into `nubspace`.

  Returns `bot`.
  """
  def set(nubspace, cupcake) do
    Bot.w(nubspace: nubspace, cupcake: fn args -> 
      ILM.Nubspace.push! args[:bot].nubspace, cupcake
    end)
    |> Castle.arrow!
  end
  
  @doc """
  Get a `Cupcake` from `nubspace`.
  """
  def get(nubspace) do
    # set :commands and spawn
    Bot.w(nubspace: nubspace, cupcake: fn args ->
      ILM.Nubspace.pull! nubspace
    end)
    |> Castle.arrow!
  end
  
  @doc """
  Jump the `Cupcakes` at `nubspace`. Returns an Event you may Bot.cap to 
  be signaled of updates.
  
  Returns `bot`.
  """
  def jmp(nubspace, cupcake \\ []) do
    Bot.w(nubspace: nubspace, cupcake: fn args ->
      # Transform the bot in real-time, from this
      # fun to the fun originally passed into exe.
      ILM.Nubspace.jump! args[:bot].cupcake(cupcake), nubspace
    end)
    |> Castle.arrow!
  end

  @doc """
  Capture a Cupcake and evaluate command.
  
  Returns `bot`.
  """
  def cap(nubspace, cupcake) do
    Bot.w(nubspace: nubspace, cupcake: fn args ->
      ILM.EmitServer.capture! nubspace, cupcake
    end)
    |> Castle.arrow!
  end
  
  
  # Private
  
  @moduledoc """
  Bots are actions/routes/requests. They much like Doge, sometimes cost more.
  """
  def w(args) do
    apply __MODULE__, :new, [Enum.concat(args, [unique: ILM.uuid])]
  end
end