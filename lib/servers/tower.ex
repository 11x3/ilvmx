defmodule ILM.Servers.Tower do
  use GenServer
  use Jazz

  @moduledoc """
  Our Tower server (or :emit stage) is where the app produces 
  most of the outside world side items, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.
  """


  @doc """
  #todo: Register external clients for Signals
  """
  def capture!(client, signal) do
    # upload a program to exe on this signal
    signal |> ILM.CPU.install! fn capture ->
      IO.inspect "(x-x-):ILM.Servers.Tower {signal: #{inspect signal.path}, capture: #{inspect capture}}"
      
      receive do
        {:commit, commit} -> 
          if signal.path == capture.path do
            send client, {:signal, commit}
          end
      end
    end
  end


  @doc "Commit `signal` to Galaxy state."
  def commit!(signal) do
    message = {:commit, signal}
    
    Task.async fn -> 
      # Application.get_env(:ilvmx, :signals) |> Enum.each fn sigmap ->
      #   send sigmap.server, message
      # end
    end
    
    signal
    |> pipe!
    |> archive!
    |> galaxy!
  end

  @doc """
  #todo: Send `signal` to external configured pipelines.
  """
  def pipe!(signal) do
    
    signal
  end

  @doc """
  Save `signal` to disk as configured.
  """
  def archive!(signal) do
    # todo: add/update commit times of signal
    # todo: add config support
    Bot.set(signal)
    
    signal
  end

  @doc """
  #todo: Share signals with the galaxy.
  """
  def galaxy!(signal) do
    
    signal
  end
  
  
  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end