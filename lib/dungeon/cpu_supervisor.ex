defmodule ILM.CPU.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link({:local, :cpu}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.CPU,  []),
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end