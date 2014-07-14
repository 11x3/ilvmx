defmodule ILM.Castle.Wizard.Supervisor do
  use Supervisor
  
  # gen_supervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # todo: add a poolboy here
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.Castle.Wizard.Server, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
