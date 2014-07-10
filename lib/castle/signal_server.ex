defmodule ILM.Castle.Signal.Server do
  use GenServer

  # Check and load custom castle scripts.
  @castle_signals   :castle_signals
  @castle_path      Path.join(File.cwd!, "castle")
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  ## Signals
  
  @doc """
  Return Castle (local) Signals.
  """
  def castle_signals do
    n = ConCache.get_or_store ILM.Castle.cache, @castle_signals, fn ->        
      castle_signals = nil
      
      # get Items from the existing castle nubspace
      if File.exists?(@castle_path) do
        castle_signals = File.ls!(@castle_path) |> Enum.map fn file_path ->
          prog_path   = Path.join(@castle_path, file_path)
          signal_path = Path.basename(prog_path, ".cake")

          Signal.m("castle/#{ signal_path }", signal_path, Program.setup(prog_path))
        end
      end
      
      castle_signals
    end
  end
    
  @doc """
  Collect signals from Castle.
  """
  def boost!(signal) do
    Signal.i(signal, castle_signals |> Enum.filter fn boost -> boost.path == signal.path end)
  end
    
  # @doc """
  # Put `signal` into Nubspace.
  # """
  # def upload!(signal) do
  #
  #   ConCache.put ILM.Castle.cache, @signals,
  #
  #   throw IO.inspect signal
  #
  #   signal
  # end

  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal) do
  #   signal
  # end


  ## Private
  
  # def tick(_) do
  #   # :timer.sleep(1000)
  #   #
  #   # signal! Effect.w "tick"
  #   #
  #   # tick(nil)
  # end
  
  
  ## GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end