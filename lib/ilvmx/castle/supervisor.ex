defmodule ILM.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({:local, :castle}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Castle,  []),
      worker(ILM.Epoch,  []),
    ]

    # start our http server
    # todo: check ILM.config before starting
    #Plug.Adapters.Cowboy.http ILM.Adapt.Web, [], port: 8080

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
