defmodule Castle.Tower.Supervisor do
  use Supervisor

  # gen_supervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do    
    children = [
      # Define workers and child supervisors to be supervised
      worker(Services.Tower,     [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
