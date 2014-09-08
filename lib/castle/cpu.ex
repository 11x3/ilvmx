defmodule Castle.CPU do
  use GenServer
  
  @castle_path Path.join(File.cwd!, "castle")
  
  @moduledoc """
  
  Castle,
  Game,
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
  #"castle/cpu/signals" |> Castle.beam! Program.cmd fn -> "(x-x-) #hello" end

  ## System
  
  @doc "Reset the Castle.Nubspace map."
  def reset! do
    #todo: self kill
  end


  @doc "Boost a `Signal` with Castle.Nubspace items!"
  def execute!(signal) do
    # promote the signal to a GenServer
    {:ok, cpu} = GenServer.start_link(Castle.CPU, nil, debug: [])
    
    # process the signal/program
    signal = GenServer.call(cpu, {:execute, signal})
  end
  
  def handle_call({:execute, signal}, from, state) do    
    IO.inspect "(x-x-):execute {signal: #{inspect signal}}"

    {:reply, Program.exe(signal), state}
  end
  
  
  ## Private


  
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
    
    IO.inspect "Castle.CPU: #{ inspect server }, castle_path: #{@castle_path}"
    
    # setup system apps
    File.ls!(@castle_path) |> Enum.each fn file_path -> 
      IO.inspect "Code.eval_file: #{ file_path }"
      Task.async fn -> Code.eval_file(Path.join(@castle_path, file_path)) end
    end
    
    link
  end
end
