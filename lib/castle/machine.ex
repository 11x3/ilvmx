require Logger

defmodule Castle.Machine do
  use GenServer
    
  @moduledoc """
  """

  ##todo: Callbacks
  #Program.compile
  #Program.before
  #Program.main
  #Program.after
  
  
  @doc "Reset the Castle.Nubspace map."
  def reset! do
    #todo: self kill
  end
  
  @doc "A stub to :ping the Castle.Machine."
  def handle_call({:ping, signal, items, duration}, from, state) do
    # call the signal server to execute
    GenServer.cast(signal.source, {:execute, signal, items, duration})
    
    {:reply, signal, state}
  end
  
  @doc "Execute `signal` with `items` for `duration` on the Castle.Machine."
  def handle_cast({:execute, signal, items, duration}, state) do
    # Logger.debug "Castle.Machine:execute
    #          cpu: #{inspect self}
    #          set: #{inspect signal.set}
    #         item: #{inspect signal.item}
    #        items: #{inspect signal.items}
    # "
    
    #todo: add dynamic :boost signal/server
    #todo: return an ownership token
    #todo: check for kill9 on signal
    #todo: fix/append the custom items to our castle items
    
    {:noreply, exe_loop(signal, Castle.map[signal.set], duration)}
  end
  
  @doc "Execute `signal` with `items` for `duration` on the Castle.Machine."
  def handle_call({:execute, signal, items, duration}, from, state) do
    # Logger.debug "Castle.Machine:execute
    #          cpu: #{inspect self}
    #          set: #{inspect signal.set}
    #         item: #{inspect signal.item}
    #        items: #{inspect signal.items}
    # "
    
    #todo: add dynamic :boost signal/server
    #todo: return an ownership token
    #todo: check for kill9 on signal
    #todo: fix/append the custom items to our castle items
    
    {:reply, exe_loop(signal, Castle.map[signal.set], duration), state}
  end
  
  
  ## Private
  defp exe_loop(signal, items, duration) do
    exe_loop(signal, items)
  end
  defp exe_loop(signal, [item|items]) do
    exe_loop(Program.exe(signal, item), items)
  end
  defp exe_loop(signal, done) when nil?(done) or length(done) == 0 do
    signal
  end
  
  ## GenServer
  
  @castle_path Path.join(File.cwd!, "castle")
  
  def handle_info(_args, _state), do: {:noreply, nil}
  
  def start_link(default \\ nil) do
    link = {:ok, server} = GenServer.start_link(Castle.Machine, default)
    
    Logger.debug "Castle.name: #{Castle.name} Castle.Machine: #{ inspect server }, castle_path: #{@castle_path}"
    
    # setup system apps
    File.ls!(@castle_path) |> Enum.each fn file_path -> 
      Logger.debug "Code.eval_file: #{ file_path }"
      Task.async fn -> Code.eval_file(Path.join(@castle_path, file_path)) end
    end
    
    link
  end
end
