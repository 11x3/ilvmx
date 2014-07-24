defmodule ILM.CPU do
  use GenServer
    
  # defmodule Player do
  #  defstruct  ownership: nil, # an Item "home" on a castle/nubspace (ie. /players/nick)
  #               # items: [],  # custom pipes/scripts
  #               #  bots: [],  # active bots (see: bot.ex)
  #               # polls: nil,  # keyword list of okcupid-like data
  #               # clans: nil,
  #               # banks: %{cash: nil, karma: nil, dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"},
  #                unique: nil

  # defmodule Signal do
  #    defstruct     path: nil,  # "about/ilvmx"
  #                  item: nil,  # data/params
  #                 items: [],   # [item]
  #                source: nil,  # sender (pid, email, nick, etc)
  #                unique: nil,  # uuid
  #                 owner: nil   # Player
  #    

  # defmodule Item do
  #      defstruct   kind: nil,  # String (eg. mime/type)
  #                unique: nil,  # "32453-4544-3434-234324-7879"
  #               content: nil,  # {:file, etc}  => "obj/32453-4544-3434-234324-7879/binary"
  #                  meta: nil   # :ilvmx        => "obj/32453-4544-3434-234324-7879/meta"

  # defmodule Program do
  #      defstruct source: nil,
  #                  code: nil,  # expression
  #                  data: %{},  # storage
  #                errors: [],   # exceptions or manual logged errors
  #                unique: nil

  ## API
  
  def signals do
    Agent.get signals_agent, fn signals -> signals end
  end
  
  
  ## Execute
  
  @doc "Execute a signal on the CPU."
  def execute!(signal) do
    IO.inspect "(x-x-).execute!: #{inspect signal}"
    
    # map Program
    #   \compile program
    #     \ unquote functions
    #     \ parse cakedown
    #   \execute program
    #   \pull data out of program
    #   \store program.data into signal.items {:item, x}
    
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(ILM.CPU, nil, debug: [])

    # process the signal/program
    GenServer.call(server, {:execute, signal, signal.source, server})
  end



  ## Install

  @doc "Install `signal` to provide `item` or `program` in the Castle memory space."
  def install!(signal) do
    install!(signal, signal.item)
  end
  def install!(signal, item) when is_binary(item) do
    install!(signal, Program.app(item))
  end
  def install!(signal, item) when is_function(item) do
    install!(signal, Program.cmd(item))
  end
  def install!(signal, item = %Item{}) do    
    # start the server
    {:ok, server} = GenServer.start_link(ILM.CPU, signal, debug: [])

    # start the signal/program
    GenServer.call(server, {:install, signal})
  
    signal
  end
  
  
  ## Kill
  
  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal, token) do
  #   {:ok, server} = GenServer.start_link(ILM.CPU, nil, debug: [])
  #
  #   # process the signal/program
  #   GenServer.cast(server, {:kill, signal, token})
  #
  #   signal
  # end
  
  
  ## callbacks

  # def handle_cast({:install, item = %Program{}, server}, signal) do
  #   # IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect item}}"
  #   #
  #   # {:ok, signal_agent} = Agent.start_link(fn -> signal end)
  #   #
  #   # # add dynamic :boost signal/server
  #   # # # todo: fix these Castle sigmaps
  #   # # sigmap = %{signal: signal.path, server: server, item: String.slice(inspect(signal.item), 0..42)}
  #   # # #todo: check for existing item
  #   # # #signals(signal.path, sigmap)
  #   # # graph the item
  #   #
  #   # message_loop(signal_agent, item, server)
  #   #
  #   #todo: return a ownership token
  #   {:noreply, :noreply}
  # end
  
  def handle_call({:install, signal}, from, state) do
    IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
    
    # graph the item
    {:reply, Bot.push(signal.path, signal.item), state}
  end
 
 
 
 
  def handle_call({:execute, signal, client, server}, _from, _nil) do
    IO.inspect "(x-x-):execute {signal: #{inspect signal.path}, client: #{inspect client}, server: #{inspect server}}"
    
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)

    # todo: collect nil/all signal.paths
    # todo: add a count/event/reduction or otherwise termination for the boost_loop 
    Task.async fn ->
      # broadcast for signal/items
      # (ILM.signals[signal.path] || []) |> Enum.each fn sigmap ->
      #   send(sigmap.server, {:boost, boost_agent, client, server})
      # end
    end
    
    # collect nubspace items
    Task.async(fn ->
      Bot.pull(signal.path) |> Enum.each fn item ->
        Agent.update signal_agent, &(Signal.a(&1, item))
      end
    end) |> Task.await
    
    {:reply, Agent.get(signal_agent, fn signal -> signal end), nil}
  end
  
  
  ## private
  
  defp message_loop(signal_agent, item, server) do
    receive do
      {:execute, boost_agent, boost_client, boost_source} ->
        # update the signal
        Agent.update boost_agent, fn signal ->
          Signal.a signal, item
        end
      {message, content} -> IO.inspect "(x-x-).message.unknown: #{inspect {message, content}}"
    end
    
    # {:boost, boost_agent, client, source} ->
    #     # # grab the two signals
    #     # boost   = Agent.get boost_agent,  fn boost  -> boost end
    #     # signal  = Agent.get signal_agent, fn signal -> signal end
    #     #
    #     # # #IO.inspect "(x-x-):ILM.Nubspace.message_loop.boost:  #{inspect boost}"
    #     # # #IO.inspect "(x-x-):ILM.Nubspace.message_loop.signal: #{inspect signal}"
    #     # #
    #     # #todo: exe program or otherwise pattern/match
    #     # #
    #     # # a dumb "boost" match to up the signal
    #     # Agent.update boost_agent,  fn signal -> Signal.a(signal, signal) end
    #     #
    #     # # # update our signal
    #     # Agent.update signal_agent, fn signal -> Signal.a(signal, boost) end
    #     #
    #     # # forward signal to client
    #     # if client do
    #     #   send client, {:update, boost_agent, server}
    #     # end
    #
    
    message_loop(signal_agent, item, server)
  end

  defp signals(path, sigmap) do
    Agent.update signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end
  
  defp signals_agent do
    Application.get_env :ilvmx, :signals
  end
  
  
  ## GenServer
  
  def handle_info(message, _nil) do
    {:noreply, _nil}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
  def start_link(default \\ nil) do
    GenServer.start_link(ILM.CPU, default)
  end
end
