defmodule ILVMX.Castle.Tower.Supervisor do
  use Supervisor

  # gen_supervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    # todo: add a poolboy of .Servers here
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILVMX.Castle.Tower.Server,     [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
