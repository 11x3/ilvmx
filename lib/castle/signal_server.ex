defmodule ILM.Castle.Signal.Server do
  use GenServer
  
  @moduledoc """
  Nubspace is a mapping of Signals -> Items on disk/memory/galaxy.
  """
  
  # Check and load custom castle scripts.
  @castle_path Path.join(File.cwd!, "castle")


  # Query Nubspace for Signals
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
  
  
  # @doc """
  # Put `item` into Nubspace.
  # """
  # def push!(signal, item) when is_binary(nubspace) and is_function(item) do
  #   #todo: store to the function to our local cache
  #   throw IO.inspect "push!(signal, item) is_function(item)"
  # end
  # def push!(signal, item) when is_binary(nubspace) and is_binary(item) do
  #   # create nub directory
  #   nub_path = Path.join("priv/static", nub_path(signal))
  #   unless File.exists? nub_path do
  #     File.mkdir! nub_path
  #   end
  #
  #   # set the static item into the nub
  #   sub_id = "#{ ILM.Castle.uuid }"
  #
  #   sub_path = Path.join(nub_path(nubspace), sub_id)
  #   file_path = Path.join("priv/static", sub_path)
  #   File.write(file_path, item)
  #
  #   # check/create the metanub
  #   meta_path = Path.join(nub_path, "meta")
  #   if File.exists? meta_path do
  #     # update our nubspace meta file to add the link to the new item
  #     items = JSON.decode!(File.read!(meta_path))
  #     items = [sub_path|items]
  #     json  = JSON.encode!(items)
  #     File.write!(meta_path, json)
  #   else
  #     File.write!(meta_path, JSON.encode!([sub_path]))
  #   end
  #
  #   ILM.Castle.Tower.Server.signal! Effect.w nubspace, [item: item, static: sub_path]
  # end
  
  
  ## GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end