defmodule Castle do
  use GenServer
  
  @epoch          :epoch
  @castle_path    Path.join(File.cwd!, "castle")

  @moduledoc """
  ILM takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILM exchange.

  # todo: add Castle.config[:name]
  # todo: support p2p between castles
  """

  ## API
  
  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  

  ## Native
  
  @doc """
  ILM network exchange.
  """
  def galaxy do
    "#ilvmx"
  end
  
  @doc """
  Castle name.
  """
  def name do
    "#lolnub"
  end
  
  @doc """
  Return an UUID.
  """
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  @doc """
  Return the regex that matches Castle.uuids
  """
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc """
  Return the general max size of an upload.
  """
  def upload_limit do
    8_000_000
  end
  
  
  ## Private
  
  defp signals_setup do
    # Load static castle scripts
    # hack: todo: fix this costly "hot" reloading
    if nil? signals_agent do
      IO.inspect "(x-x-)...setup: #{ inspect self }"
    
      try do
        if File.exists?(@castle_path) do
          castle_signals = File.ls!(@castle_path) |> Enum.map fn file_path ->
            prog_path   = Path.join(@castle_path, file_path)
            signal_path = Path.basename(prog_path, Path.extname(prog_path))
        
            Program.app(prog_path)
          end
        end
      rescue
        x in [RuntimeError, ArgumentError, BadArityError] ->
          IO.inspect "(x-x-).setup_castle.FAILED: #{inspect x}"
      end
    end
  end
  
  defp signals_agent do
    Application.get_env :ilvmx, :signals
  end
  
  defp signals(path, sigmap) do
    Agent.update signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end
  
  ## GenServer

  def start_link do
    link = GenServer.start_link(__MODULE__, nil)

    Task.async fn -> signals_setup end

    # setup plug adapters
    Plug.Adapters.Cowboy.http Castle.Services.Plug, [], port: 8080
    #todo: support config for starting options
    
    link
  end
end