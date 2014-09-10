defmodule Castle.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [debug: [:trace]])
  end

  def init(opts \\ nil) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Castle,                    []),
      worker(Castle.CPU.Supervisor,     []),
      worker(Castle.Game.Supervisor,    []),
      worker(Castle.Wizard.Supervisor,  [])
    ]
    
    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
