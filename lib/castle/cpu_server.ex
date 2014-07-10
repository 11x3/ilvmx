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
  
  def execute!(signal) do
    signal
  end
  def execute!(signal = %Signal{}, [effect|items_tail]) do
    execute!(signal, effect)
    execute!(signal, items_tail)
  end
  def execute!(signal = %Signal{}, program = %Program{}) do
    # todo: compile programs inside signal.items
    throw IO.inspect program
    
    signal
  end
  def execute!(signal = %Signal{}, effect) do
    
    effect
  end

  ## GenServer Callbacks
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
