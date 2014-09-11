require Logger

defmodule Castle.Game do
  use GenServer

  @moduledoc """
  # todo: add config support
  """
  
  # ## Our feature presentation.
  #
  # @doc "Publish a `Signal` to the Game rules."
  # def host!(signal) do
  #   #todo: validate signal
  #   # signal_map = Dict.update(Castle.map, signal.set, [signal], fn signals -> [signal|signals] end)
  #   # Application.put_env :ilvmx, :signal, %Signal{Castle.signal| item: signal_map, items: [signal|Castle.signal.items]}
  #
  #   signal
  # end
  #
  # @doc "Remove a `Signal` from the Game map."
  # def kick!(signal) do
  #   #Application.put_env :ilvmx, :signal,
  #
  #   signal
  # end
  #
  # @doc "Run `signal` through the Castle.Game."
  # def run!(signal, items \\ Castle.signal.items) do
  #   Logger.debug "Castle.Game.run!/signal: #{inspect signal}"
  #
  #   signal
  # end
  #
  # @doc "Remove a `Signal` from the Game map."
  # def kick!(signal) do
  #   Logger.debug "Castle.Game.run!/signal: #{inspect signal}"
  #
  #   signal
  # end

  ## GenServer Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

end