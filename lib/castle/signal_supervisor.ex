defmodule ILM.SignalServer.Supervisor do
  use Supervisor

  @castle_path Path.join(File.cwd!, "castle")

  @doc "Load disk-based castle programs."  
  def castle_programs do
    # get Items from the existing castle nubspace
    if File.exists?(@castle_path) do
      castle_signals = File.ls!(@castle_path) |> Enum.map fn file_path ->
        prog_path   = Path.join(@castle_path, file_path)
        signal_path = Path.basename(prog_path, ".cake")

        Signal.u("castle/#{ signal_path }", signal_path, Program.setup(prog_path))
      end
    end  
  end
  
  ## GenSupervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # Load custom castle programs.
    Task.async fn -> castle_programs end
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.SignalServer, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
