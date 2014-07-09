defmodule ILM.Castle.Signal.Server do
  use GenServer
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  # Check and load custom castle scripts.
  @castle_path Path.join(File.cwd!, "castle")

  def capture!(signal) do
    #todo: start or broadcast/search for an existing signal_server
    #todo: store program

    # Load our custom Castles here.
    if File.exists?(@castle_path) do
      # files |> signals
      Signal.e signal, File.ls!(@castle_path) |> Enum.map fn file_path ->
        prog_path = Path.join(@castle_path, file_path)
        signal_path = Path.basename(prog_path, ".cake")
        if signal_path == signal.path do
          Effect.w(signal_path, Program.run(prog_path))
        else
          nil
        end
      end
    end
  end
  
  
  ## Private

  def signals do
    n = ConCache.get_or_store ILM.Castle.cache, @signals, fn ->
      []
    end
  end
  
  
  ## GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end