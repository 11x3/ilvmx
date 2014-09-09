require Logger

defmodule Hug do
  use GenServer
  
  @moduledoc """
  A promise to get an Item at a later date.
  """
  
  def me(signal, item) do
    #todo: add the promised item to the signal
    
    signal
  end
  
end