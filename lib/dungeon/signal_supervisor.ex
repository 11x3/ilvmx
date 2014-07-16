defmodule ILM.SignalSupervisor do
  use Supervisor

  @castle_path Path.join(File.cwd!, "castle")
  
  @doc "Load disk-based castle programs."  
  def setup_castle do
    IO.inspect "(x-x-):SignalSupervisor.setup_castle: #{ inspect self }"
        
    try do
      # get Items from the existing castle nubspace
      if File.exists?(@castle_path) do
        castle_signals = File.ls!(@castle_path) |> Enum.map fn file_path ->
          prog_path   = Path.join(@castle_path, file_path)
          signal_path = Path.basename(prog_path, Path.extname(prog_path))
          
          Signal.u signal_path, Bot.item Program.exe(prog_path)
        end
      end
    rescue
      x in [RuntimeError, ArgumentError, BadArityError] ->
        IO.inspect "(x-x-):failed setup_castle"
    end
  end

  ## GenSupervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # Load custom castle programs.
    Task.async(fn -> setup_castle end)
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.SignalServer,  [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
