defmodule ILM.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({:local, :ilm}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.NubspaceSupervisor,  []),
      worker(ILM.BotLabSupervisor,    []),
    ]
    # start our http server
    # todo: check ILM.config before starting
    Plug.Adapters.Cowboy.http ILM.WebServer, []

    
    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
