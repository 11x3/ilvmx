use Jazz

defmodule ILM.Castle.Tower.Server do
  use GenServer
    
  @signals  :signals
  
  @moduledoc """
  Our ILM.Castle.Tower.Server (or :emit stage) is where our apps produce 
  most of their outside world side effects, which come from signals that are 
  generated during the :adapt, and :transform stage of the app.
  """

  # def tick(_) do
  #   # :timer.sleep(1000)
  #   #
  #   # signal! Effect.w "tick"
  #   #
  #   # tick(nil)
  # end
  
  ## Signals

  @doc """
  Commit the Signal to galaxy state.
  """
  def commit!(signal) do
    signal
    |> pipe!
    |> archive!
    |> galaxy!
  end

  # @doc """
  # """
  # def signal!(signal = %Signal{}) do
  #   signal.effects |> Enum.each &signal!/1
  # end
  # def signal!(effect) do
  #   signals |> Enum.each fn [signal: signal, program: program] ->
  #     if signal == effect.source do
  #       program.(effect)
  #     end
  #   end
  #
  #   effect
  # end

  @doc """
  Send the signal to external pipelines.
  """
  def pipe!(signal) do
    
    signal
  end

  @doc """
  Save to disk.
  """
  def archive!(signal) do
    # # create nub + meta directory
    # signals = "priv/static/obj/signals"
    # unless File.exists? signals do
    #   File.mkdir! signals
    # end
    #
    # # check/create the metanub
    # file = Path.join(signals, signal.unique)
    #
    # # todo: add/update commit times of signal
    # File.write!(file, JSON.encode!(signal))

    signal
  end

  @doc """
  Share signals with the galaxy.
  """
  def galaxy!(signal) do
    
    signal
  end
  
  
  ## Private

  @doc """
  Return all signals in the Castle ILM.Castle.Signal.Server.
  """
  def signals do
    n = ConCache.get_or_store ILM.Castle.cache, @signals, fn ->
      []
    end
  end

  ## GenServer Callbacks
  
  def start_link do
    ConCache.put ILM.Castle.cache, @signals, []

    #todo: refactor tick into Castle.Epoch.Server.
    #spawn __MODULE__, :tick, [[]]
    
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, nil, [])
  end
end