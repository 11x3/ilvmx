defmodule ILM.CPU.Supervisor do
  use Supervisor
  
  @castle_path Path.join(File.cwd!, "castle")

  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  
  defp signals(path, sigmap) do
    Agent.update signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end

  defp signals_agent do
    Application.get_env :ilvmx, :signals
  end
  
  defp setup do
    # Load static castle scripts
    # hack: todo: fix this costly "hot" reloading
    unless map_size(signals) > 0 do
      IO.inspect "(x-x-)...setup: #{ inspect self }"
        
      try do
        if File.exists?(@castle_path) do
          castle_signals = File.ls!(@castle_path) |> Enum.map fn file_path ->
            prog_path   = Path.join(@castle_path, file_path)
            signal_path = Path.basename(prog_path, Path.extname(prog_path))
          
            Program.exe(prog_path)
          end
        end
      rescue
        x in [RuntimeError, ArgumentError, BadArityError] ->
          IO.inspect "(x-x-).setup_castle.FAILED: #{inspect x}"
      end
    end
  end
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    Task.async(fn -> setup end)
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.CPU,  []),
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
