defmodule ILVMX.Nubspace.Server.Supervisor do
  use Supervisor.Behaviour
  
  # gen_supervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # todo: add a poolboy here
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILVMX.Nubspace.Server, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end