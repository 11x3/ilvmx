defrecord Bot, 
      plug: nil,
    script: [],           # [nubs_to_hit]
   results: [],           # effects[[updated: :nub]]
  problems: [],           # [events]
   account: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
    unique: nil do   # callback
  
  alias ILM.Nubspace
  
  @moduledoc """
  Bots are Actions/Routes/Requests. They much like Doge, sometimes cost more.
  
  Nub[
    method: :ilm,
    unique: ILM.uuid,
    galaxy: nil,
    castle: nil,
    system: nil,
    domain: nil,
    module: nil,
    member: nil,
    bucket: []
  ]  
  """
  def w(args \\ []) do
    apply __MODULE__, :new, [args ++ [unique: ILM.uuid]]
  end
  
  @doc """  
  Tell a Bot to get and exe a Nubspace.
  """
  def exe(nubspace) when is_binary nubspace do
    exe Nubspace.get nubspace
  end
  
  @doc """  
  Tell a Bot to exe a Nub.
  """
  def exe(nub = Nub[]) do
    ILM.BotLab.exe Bot.w script: [nub]
  end
  
  @doc """  
  Tell a Bot to exe against a Plug connection.
  """
  def plug(conn, opts) do
    ILM.BotLab.exe Bot.w plug: [conn: conn, opts: opts]
  end
  


  @doc """  
  Add a global route to this Castle for Bots to take.
  """
  defmacro cmd(nubspace, do: script) do
    quote do
      ILM.BotLab.exe Bot.w script: [unquote(script)]
    end
  end
  
end