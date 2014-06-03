defmodule ILVMX.Castle.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link({:local, :castle}, __MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised      
      worker(ILVMX.Castle.Tower.Supervisor,   []),
      worker(ILVMX.Castle.Server,             []),
    ]
    
    #todo: support ILM.config for starting options
    Plug.Adapters.Cowboy.http ILVMX.Plug.Server, [], port: 8080
    
    # Load our custom Castles here.
    project   = File.cwd!
    
    # Check and load custom castle scripts.
    castledir = Path.join(project, "castle")
        
    if File.exists? castledir do
      castles = File.ls!(castledir) |> Enum.each fn file ->
        castlefile = Path.join(castledir, file)
        
        if Path.extname(castlefile) == ".exs" do
          Code.eval_file castlefile
        end
      end
    end
     
    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
