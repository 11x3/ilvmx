defmodule ILM.SignalServer do
  use GenServer
  
  @moduledoc """
  SignalServer or Nubspace server is a mapping of Signals -> Items 
  on disk/memory/galaxy. Program items are further sent to the CPU.
  """
  
  # defmodule Signal do
  #   defstruct     path: nil,  # "about/ilvmx"
  #                 item: nil,  # data/params
  #                items: [],   # [item]
  #               source: nil,  # sender (pid, email, nick, etc)
  #               unique: nil   # uuid
  
  
  ## Uploads

  @doc "Run `program` on `signal` in Castle nubspace."
  def upload!(signal) do
    upload!(signal, signal.item)
  end

  def upload!(signal, item = %Item{}) do
    {:ok, server} = GenServer.start_link(__MODULE__, signal, debug: [])
    
    # store the signal/program
    GenServer.cast(server, {:upload, signal, item, server})
  end
  def upload!(signal, item = %Item{}, program = %Program{}) do    
    # store the signal
    # todo: store the program in ILM.CPU
    throw "unsupported"
  end
  def upload!(signal, item) do
    #todo: store the program to disk for future exe
    #todo: return an error item with unknown support
    throw "unsupported"
  end
  
  def handle_cast({:upload, signal, item, server}, signal) do
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)

    # for the App.env global registry
    sigmap = %{signal: signal.path, server: server, content: String.slice(inspect(signal.item), 0..42)}
    
    ILM.signals(signal.path, sigmap)
    
    IO.inspect "(x-x-):SignalServer.upload! #{inspect sigmap}}"
    IO.inspect "(x-x-):SignalServer.signals: #{inspect ILM.signals}}"

    #todo: return a UUID-based token for ownership    
    message_loop(signal_agent, item, server)

    {:noreply, signal}
  end
 
  def message_loop(signal_agent, item, server) do
    receive do
      {:boost, boost_agent, boost_client, boost_source} ->
        # update the signal
        Agent.update boost_agent, fn signal ->
          Signal.i signal, item
        end

      {message, content} -> IO.inspect "(x-x-).message_loop: #{inspect {message, content}}"
    end

    message_loop(signal_agent, item, server)
  end


  ## Boosts
 
  @doc "Collect signals from Nubspace."
  def boost!(signal) do
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
    IO.inspect "(x-x-):SignalServer.boost! {signal: #{signal.path}, client: #{inspect self}}"

    # process the signal/program
    signal = GenServer.call(server, {:boost, signal, signal.source, server})
    
  end
 
  def handle_call({:boost, signal, client, server}, _from, _nil) do
    IO.inspect "(x-x-):SignalServer :boost {signal: #{inspect signal.path}, client: #{inspect client}, server: #{inspect server}}"
    IO.inspect "(x-x-):ILM.signals: #{inspect ILM.signals}"
    
    {:ok, boost_agent} = Agent.start_link(fn -> signal end)

    #todo: collect nil/all signals support
    # todo: add a count/event/reduction or otherwise termination for the boost_loop 
    Task.async fn ->
      # broadcast for signal/items
      (ILM.signals[signal.path] || []) |> Enum.each fn sigmap ->
        send(sigmap.server, {:boost, boost_agent, client, server})
      
        IO.inspect "(x-x-) :signal: #{inspect signal.path}, sigmap: #{inspect sigmap}}"
      end
    end
    
    # todo: collect nubspace items
    Bot.pull(signal.path) |> Enum.each fn item ->
      Agent.update boost_agent, &(Signal.i(&1, item))
    end
     
    {:reply, boost_loop(boost_agent, client, server), nil}
  end

  def boost_loop(boost_agent, client, server) do
    receive do
      {:item, item, server} ->
        IO.inspect "(x-x-):SignalServer.boost_loop :update"
        
        # map signal.items = Item
        #   \return item/link

        boost_loop(boost_agent, client, server)
        
    after
      1000 -> Agent.get boost_agent, fn signal -> signal end
    end
  end
  

  ## GenServer
  
  def handle_info({:DOWN, ref, process, _pid, _reason}, _nil) do
    {:noreply, _nil}
  end

  def handle_info(msg, state) do
    {:noreply, state}
  end
  
  def init(opts \\ nil) do
    {:ok, opts}
  end
  
  def start_link(opts \\ nil) do
    IO.inspect "(x-x-):SignalServer.start_link self: #{inspect self} opts: #{inspect opts}"
    
    GenServer.start_link(__MODULE__, opts)
  end
  
end