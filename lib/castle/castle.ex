defmodule Castle do
  use GenServer

  @epoch :epoch

  @moduledoc """
  ILM takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILM exchange.

  Castle [
    Game [
      Map/Wizard/Players/Services
    ],
    CPU [
      Signals/Programs/Items/Bots
    ],
  ]
  """
  
  ## System
  def x(binary) do
    Castle.boost? Signal.m binary
  end
  
  @doc "Return the `Castle.signal` of yore."
  def signal do
    Application.get_env :ilvmx, :signal
  end
  
  @doc "Our signal map."
  def map do
    Castle.Game.map
  end


  ## API

  @doc "Ping a `signal_path` of the Castle.Nubspace and return *all* `Castle.signals`."
  def beam!(signal = %Signal{}) do
    IO.inspect "Castle.beam!: #{signal.path}"
    
    signal |> Castle.Game.host!
  end
  
  @doc "Boost `signal` with appropriate Castle.Nubspace items."
  def boost?(signal = %Signal{}) do
    IO.inspect "Castle.boost?: #{inspect signal.path}"

    Castle.Game.run! signal, Castle.map[signal.path]
  end
  
  @doc "Return updated items and noops our worker."
  def next?(items \\ nil) do
    unless nil?(items) or not is_list(items) do 
      Application.put_env :ilvmx, :signal, Signal.boost!(signal, items)
    end
    
    {:ok, karma: "#todo", next: "#todo"}
  end
  
  @doc "Return the `Castle.signal.items` – all of them. #todo: add streams"
  def download do
    IO.inspect "Castle.download"

    signal.items
  end

  
  ## Public
  
  @doc "ILvMx network exchange."
  def galaxy do
    "ilvmx"
  end
  
  @doc "Castle name."
  def name do
    "#{ galaxy }/lolnub"
  end
  
  @doc "Return an UUID."
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  
  ## Misc.
  
  @doc "Return the regex that matches Castle.uuids"
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc "Return the general max size of an upload."
  def upload_limit do
    8_000_000
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
    link = {:ok, castle} = GenServer.start_link(Castle, default)
    
    IO.inspect "Castle: #{ inspect castle }"

    link
  end
  
end