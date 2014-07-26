defmodule Castle.CPU do
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
  
  @doc "Execute a signal on the Castle.CPU."
  def execute!(signal) do
    # promote the signal to a GenServer
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # process the signal/program
    GenServer.call(server, {:execute, signal, signal.source, server})
    |> Castle.Wizard.review?
    |> Services.Tower.commit!
  end

  
  ## Capture
  
  @doc "Capture and repeatedely execute Program on Castle.CPU."
  def capture!(signal) do
    IO.inspect "(x-x-):capture! {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    # start the server
    {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])

    # start the signal/program
    #GenServer.cast(server, {:capture, signal})
    
    signal
    |> Castle.Wizard.review?
    |> Services.Tower.beam!
  end
  
  ## Install
  
  @doc "Install `signal` to disk to provide `item` or `program` in Castle.Nubspace."
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
    {:ok, server} = GenServer.start_link(Castle.CPU, signal, debug: [])

    # start the signal/program
    GenServer.call(server, {:install, signal})
  end
  
  
  ## Kill
  
  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal, token) do
  #   {:ok, server} = GenServer.start_link(Castle.CPU, nil, debug: [])
  #
  #   # process the signal/program
  #   GenServer.cast(server, {:kill, signal, token})
  #
  #   signal
  # end
  
  
  ## Callbacks
  
  def handle_call({:execute, signal, client, server}, from, state) do
    IO.inspect "(x-x-).execute!: #{inspect signal.path}"

    # collect nubspace items
    signal = Task.async(fn ->
      Signal.a signal, Bot.pull(signal.path)
    end) |> Task.await
    
    # todo: collect galaxy signals

    {:reply, signal, nil}
  end

  def handle_cast({:capture, signal}, state) do
    IO.inspect "(x-x-):capture {signal: #{inspect signal.path}, program: #{inspect signal.item}}"
    
    {:ok, signal_agent} = Agent.start_link(fn -> signal end)
    
    #todo: check for kill9 on signal

    # # add dynamic :boost signal/server
    # # # todo: fix these Castle sigmaps
    # # sigmap = %{signal: signal.path, server: server, item: String.slice(inspect(signal.item), 0..42)}
    # # #todo: check for existing item
    # # #signals(signal.path, sigmap)
    # # graph the item
    
    #todo: return a ownership token
    {:noreply, exe(signal_agent, signal.item)}
  end
  
  def exe(signal_agent, program) do
    signal_item = fn item ->
      Agent.update signal_agent, fn signal -> Signal.a(signal, item) end
    end
    
    signal = Agent.get signal_agent, fn signal -> signal end
    
    # add the signal_item function to the program's data
    data = %{
      signal_item: signal_item,
      signal: signal,
      cpu: self
    }
    program = %{program| data: Map.merge(program.data, data) }

    Program.exe(program)
  end
  
  
  def handle_call({:install, signal}, from, state) do
    IO.inspect "(x-x-):install {signal: #{inspect signal.path}, item: #{inspect signal.item}}"
    
    # graph the item
    
    #todo: return a ownership token
    {:reply, %{signal| item: Bot.push(signal.path, signal.item)}, state}
  end
  
  ## private
  
  # defp message_loop(signal_agent, item, server) do
  #   receive do
  #     {:execute, signal_agent, client, source} ->
  #       # update the signal
  #       Agent.update signal_agent, fn signal ->
  #         Signal.a signal, item
  #       end
  #
  #   # {:boost, boost_agent, client, source} ->
  #   #     # # grab the two signals
  #   #     # boost   = Agent.get boost_agent,  fn boost  -> boost end
  #   #     # signal  = Agent.get signal_agent, fn signal -> signal end
  #   #     #
  #   #     # # #IO.inspect "(x-x-):Nubspace.message_loop.boost:  #{inspect boost}"
  #   #     # # #IO.inspect "(x-x-):Nubspace.message_loop.signal: #{inspect signal}"
  #   #     # #
  #   #     # #todo: exe program or otherwise pattern/match
  #   #     # #
  #   #     # # a dumb "boost" match to up the signal
  #   #     # Agent.update boost_agent,  fn signal -> Signal.a(signal, signal) end
  #   #     #
  #   #     # # # update our signal
  #   #     # Agent.update signal_agent, fn signal -> Signal.a(signal, boost) end
  #   #     #
  #   #     # # forward signal to client
  #   #     # if client do
  #   #     #   send client, {:update, boost_agent, server}
  #   #     # end
  #   #
  #  #     {message, content} -> IO.inspect "(x-x-).message.unknown: #{inspect {message, content}}"
  #   message_loop(signal_agent, item, server)
  # end

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
    GenServer.start_link(Castle.CPU, default)
  end
end
