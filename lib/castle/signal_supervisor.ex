defmodule ILM.Castle.Signal.Server.Supervisor do
  use Supervisor
  
  ## Signals
  
  @doc """
  """
  def signal!(signal) do
    Signal.x signal, signals
  end

  @doc """
  """
  def capture!(signal) do
      
  end
  
  
  
  
  
  
  
  
  
  
  
  
  ## Private
  
  def signals do
    n = ConCache.get_or_store ILM.Castle.cache, @signals, fn ->
      castle_signals
    end
  end
 
  def castle_signals do
    # Load our custom Castles here.
    project   = File.cwd!

    # Check and load custom castle scripts.
    castle_path = Path.join(project, "castle")
    
    if File.exists?(castle_path) do
      # files |> signals
      programs = File.ls!(castle_path) |> Enum.map fn file_path ->
        Program.run Path.join(castle_path, file_path)
      end |> Enum.map fn program ->
        
      end

      programs      
    end
  end
  
  
  # gen_supervisor
  
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    # todo: add a poolboy here
    
    children = [
      # Define workers and child supervisors to be supervised
      worker(ILM.Castle.Signal.Server, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
