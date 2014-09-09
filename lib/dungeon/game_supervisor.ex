defmodule Castle.Game.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Castle.Game,  []),
    ]

    # setup arcade/adapters
    # todo: support config for starting options
    Plug.Adapters.Cowboy.http Castle.Plug, [self], port: 8080
    
    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
