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

  ## Signals
  
  @doc "A map of the Castle.Nubspace"
  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  
  @doc "Install a Signal from an optional `source` at `path` with `item`."
  def s(path, item) when is_function(item) do
    Castle.s(self, path, Program.cmd(item))
  end
  def s(path, item) do
    Castle.s(self, path, item)
  end
  def s(source, path, item) do
    Signal.m(source, path, item) |> Castle.Wizard.please? |> Castle.CPU.install!
  end

  @doc "Capture a signal path for `duration` in Castle.Nubspace."
  def c(path) do
    c(self, path)
  end
  def c(source, path, duration \\ 1000) do
    Signal.m(source, path) |> Castle.Wizard.please? |> Castle.CPU.capture!
  end
  
  @doc "Execute a `Signal` `path` with optional `data`."
  def x(path) do
    x(self, path, nil)
  end
  def x(path, item) do
    x(self, path, item)
  end
  def x(source, path, item) do
    Signal.m(source, path, item) |> Castle.Wizard.please? |> Castle.CPU.execute!
  end
  
  
  ## API
  
  @doc "ILvMx network exchange."
  def galaxy do
    "#ilvmx"
  end
  
  @doc "Castle name."
  def name do
    "#lolnub"
  end
  
  @doc "Return an UUID."
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  @doc "Return the regex that matches Castle.uuids"
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc "Return the general max size of an upload."
  def upload_limit do
    8_000_000
  end
  
  
  ## Private

  # Load static castle scripts  
  defp signals_setup do
    # hack: todo: fix this costly "hot" reloading
    IO.inspect "(x-x-)...setup: #{ inspect self }"
  
    try do
      if File.exists?(@castle_path) do
        File.ls!(@castle_path) |> Enum.each fn file_path ->
          Path.join(@castle_path, file_path) |> Program.app
        end        
      end
    rescue
      x in [RuntimeError, ArgumentError, BadArityError] ->
        IO.inspect "(x-x-).setup_castle.FAILED: #{inspect x}"
    end
  end
  
  defp signals_agent do
    Application.get_env :ilvmx, :signals
  end
  
  def signals(path, sigmap) do
    Agent.update signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end
  
  ## GenServer

  def start_link do
    link = GenServer.start_link(__MODULE__, nil)

    # init signals
    signals_setup

    # setup arcade/adapters
    # todo: support config for starting options
    Plug.Adapters.Cowboy.http Castle.Arcade.Plug, [self], port: 8080
    
    link
  end
end