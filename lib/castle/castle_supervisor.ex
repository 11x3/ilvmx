defmodule ILM.Castle.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link({:local, :castle}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised      
      worker(ILM.Castle.Tower.Supervisor,   []),
      worker(ILM.Castle,             []),
    ]
    
    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
