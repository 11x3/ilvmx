require Logger

defmodule Castle.CPU do
  use GenServer
  
  @castle_path Path.join(File.cwd!, "castle")
  
  @moduledoc """
  
  Castle [
    Game,
    CPU = [
      Signals/Castle.Nubspace [
        Programs/Items/Bots
      ],
    ]
  ]
  
  Program = [
    compile,
    unquote_functions,
    parse_cakedown,
    execute_program,
    store program.effects into signal.items
  ]

  Program.exe signal.item
  |> Program.compile
  |> Program.before
  |> Program.main
  |> Program.after
  
  ## Callbacks  #
  #
  # defmodule Program do
  #   defstruct source: nil,
  #               code: nil,  # expression
  #               data: %{},  # storage
  #            effects: [],
  #             errors: [],   # exceptions or manual logged errors
  #             unique: nil
  
  """
  #"castle/cpu/signals" |> Castle.beam! Program.cmd fn -> "...\ #hello" end

  ## System
  
  @doc "Reset the Castle.Nubspace map."
  def reset! do
    #todo: self kill
  end


  @doc "Boost a `Signal` with Castle.Nubspace items!"
  def execute!(signal, items \\ []) do
    # promote the signal to a GenServer
    {:ok, cpu} = GenServer.start_link(Castle.CPU, nil, debug: [])
    
    # process the signal/program
    GenServer.call(cpu, {:execute, signal, items})
  end
  
  def handle_call({:execute, signal, items}, from, state) do
    Logger.debug "Castle.CPU:execute {signal.set: #{inspect signal.set} signal.item: #{inspect signal.item} signal.items: #{inspect signal.items}}"
    
    #todo: add dynamic :boost signal/server
    #todo: return a ownership token
    #todo: check for kill9 on signal
        
    {:reply, exe_loop(signal, items), state}
  end
  
  ## Private
  # defp exe_loop(signal, items, duration) do
  #   Logger.debug "...\<exe_loop/3"
  #
  #   receive do
  #     {:boost, content} ->
  #       Logger.debug "...\:boost: #{inspect content}"
  #
  #     {message, content} ->
  #       Logger.debug "...\:message.unknown: #{inspect {message, content}}"
  #
  #   after duration -> true
  #   end
  #
  #   exe_loop(signal, items)
  # end
  defp exe_loop(signal, [item|items]) do
    #Logger.debug "...\<exe_loop/[item|items]"
        
    exe_loop(Program.exe(signal, item), items)
  end
  defp exe_loop(signal, done) when nil?(done) or length(done) == 0 do
    #Logger.debug "...\<exe_loop/signal.items: #{inspect signal.items}"
    
    signal
  end
  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
    
    {:noreply, nil}
  end
  
  def handle_info(message, state) do
    {:noreply, nil}
  end
  
  def handle_info(_args, _state) do
    {:noreply, nil}
  end

  def start_link(default \\ nil) do
    link = {:ok, server} = GenServer.start_link(Castle.CPU, default)
    
    Logger.debug "Castle.name: #{Castle.name} Castle.CPU: #{ inspect server }, castle_path: #{@castle_path}"
    
    # setup system apps
    File.ls!(@castle_path) |> Enum.each fn file_path -> 
      Logger.debug "Code.eval_file: #{ file_path }"
      Task.async fn -> Code.eval_file(Path.join(@castle_path, file_path)) end
    end
    
    link
  end
end
