defmodule ILM.Castle.CPU.Server do
  use GenServer
  
  # defmodule Item do
  #   defstruct   kind: nil,  # String (eg. mime/type)
  #             unique: nil,  # "32453-4544-3434-234324-7879"
  #             object: nil,  # %{} => "/obj/32453/meta"
  #             binary: nil   # ""  => "/obj/32453/4544-3434-234324-7879"
            
  # defmodule Program do
  #   defstruct source: nil,  # Item
  #               code: [],   # [terms]
  #               data: %{},  # storage
  #             errors: [],   # exceptions or manual logged errors
  #             unique: nil
    
  @doc "Execute a program one time on the CPU."
  def execute!(signal) do
    IO.inspect "(x-x-):CPU.Server.signal: #{inspect signal}"
    
    # filter signal.items for programs
    # compile programs
    # execute programs
    
    signal
    |> ILM.Castle.Wizard.Server.filter?
    |> ILM.Servers.Tower.commit!
  end
  
    
  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
