defmodule Castle.CPU do
  use GenServer
  import Castle
  
  @moduledoc """
  
  CPU = [
    Signals/Castle.Nubspace,
    Programs/Bots/Items
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
  
  @nubspace %{}
  
  ## GenServer
  
  def handle_info(timeout, state) do
    #todo: setup epoch
  end
  
  def handle_info(message, state) do
    {:reply, state}
  end

  def start_link(default \\ nil) do
    GenServer.start_link(Castle.CPU, default)
  end
end
