defmodule Castle.CPU do
  use GenServer
  
  @castle_path Path.join(File.cwd!, "castle")
  
  @moduledoc """
  
  CPU = [
    Signals/Castle.Nubspace [
      Programs/Items/Bots
    ],
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
  
  """
  #"castle/cpu/signals" |> Castle.beam! Program.cmd fn -> "(x-x-) #hello" end
  
  @doc "A map of the Castle.Nubspace"
  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  
  @doc "Map Castle.Nubspace signal paths to internal sigmaps."
  def signals(path) do
    Agent.update signals_agent, fn signals ->
      #Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
      
      signals
    end
  end

  def query?(signal_path) do
    
  end
  
  def install!(signal, duration \\ 0, auto \\ false) do
    # promote the signal to a GenServer
    {:ok, cpu} = GenServer.start_link(Castle.CPU, nil, debug: [])
        
    # process the signal/program
    signal = GenServer.call(cpu, {:install, signal, duration, auto})
    |> Castle.Game.commit!
  end
  
  def handle_call({:install, signal, duration, auto}, from, state) do
    IO.inspect "Castle.CPU.install: path: ##{signal.path} state: #{inspect state}"
    
    # map Program
    # compile program
    # unquote functions
    # parse cakedown
    # execute program
    # pull data out of program
    # store program.data into signal.items {:item, x}
  
    # |> Program.compile
    # |> Program.before
    # |> Program.main
    # |> Program.after
    
    {:reply, signal, state}
  end
  
  
  ## Private

  defp signals_agent do
    Application.get_env(:ilvmx, :castle_agent)
  end
  
  # # Load static castle scripts
  defp setup do
    # hack: todo: fix this costly "hot" reloading
    IO.inspect "Castle.setup: #{ inspect self }"

    if File.exists?(@castle_path) do
      File.ls!(@castle_path) |> Enum.each fn file_path ->
      IO.inspect "Castle.setup: #{ file_path }"
        if Castle.Wizard.valid_path?(file_path) && File.exists?(file_path) do
          Code.eval_file file_path
        end
      end
    end
  end
  
  
  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
    
    {:reply, state}
  end
  
  def handle_info(message, state) do
    {:reply, state}
  end

  def start_link(default \\ nil) do
    link = {:ok, server} = GenServer.start_link(Castle.CPU, default)
    IO.inspect "Castle.CPU: #{ inspect server }"
    
    # setup system apps
    setup
        
    link
  end
end
