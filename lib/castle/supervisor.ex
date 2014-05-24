defmodule ILvMx.Castle.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({:local, :castle}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Castle,  []),
      worker(ILvMx.Castle.Tower,  []),
    ]

    # start our http server
    # todo: check ILvMx.config before starting
    Plug.Adapters.Cowboy.http ILvMx.Adapt.Web, [], port: 8080

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
