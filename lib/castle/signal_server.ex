defmodule ILM.Castle.Signal.Server do
  use GenServer
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  # Check and load custom castle scripts.
  @castle_path Path.join(File.cwd!, "castle")

  def capture!(signal) do
    # todo: start or broadcast/search for an existing signal_server
    
    # # get Items from the existing castle nubspace
    # unless File.exists?(@castle_path) do
    #   [signal]
    # else
    #   [signal, File.ls!(@castle_path) |> Enum.map fn file_path ->
    #     prog_path = Path.join(@castle_path, file_path)
    #     signal_path = Path.basename(prog_path, ".cake")
    #     if signal_path == signal.path do
    #       Program.setup(prog_path)
    #     end
    #   end]
    # end
    
    signal
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  ## GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end