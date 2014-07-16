defmodule ILM.CPU do
  use GenServer
  
  @signals :signals
  
  # defmodule Signal do
  #   defstruct     path: nil,  # "about/ilvmx"
  #                 item: nil,  # Item/Program/data/params
  #                items: []    # [list|{:item, x}]
  #               source: nil,  # sender (pid, email, nick, etc)
  #               unique: nil,  # uuid
  #
  # defmodule Program do
  #   defstruct   code: nil,  # expression
  #               data: %{},  # storage
  #             errors: [],   # exceptions or manual logged errors
  #             unique: nil
  #
  # defmodule Item do
  #   defstruct   kind: nil,  # String (eg. mime/type)
  #             unique: nil,  # "32453-4544-3434-234324-7879"
  #             object: nil,  # %{}     => "obj/32453-4544-3434-234324-7879/object"
  #             binary: nil,  # :file   => "bin/32453-4544-3434-234324-7879/binary"
  #             review: nil   # :ilvmx  => "rev/32453-4544-3434-234324-7879/meta"

  ## Execute
  
  @doc "Execute a program one time on the CPU."
  def execute!(program) do
    IO.inspect "(x-x-):CPU.Server.execute!: #{inspect program}"
    IO.inspect "(x-x-):~tsignals: #{ inspect Application.get_env(:ilvmx, @signals) }"

    # map Program
    #   \compile program
    #   \execute program
    #   \pull data out of program
    #   \store program.data into signal.items {:item, x}
    
    program
  end
  
  # ## Install
  #
  # @doc "Run `program` in Castle nubspace."
  # def install!(program) when is_binary(program) do
  #   install!(Program.app(program))
  # end
  # def install!(program) when is_function(program) do
  #   install!(Program.cmd(program))
  # end
  # def install!(program = %Program{}) do
  #   #debug: :trace, :log, :statistics
  #
  #   {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
  #
  #   # store the signal/program
  #   GenServer.call(server, {:install, program, server})
  # end
  #
  # def handle_call({:install, program, server}, client, opts) do
  #   {:ok, agent} = Agent.start_link(fn -> program end)
  #
  #   # # for the App.env global registry
  #   # sigmap = %{agent: agent, server: server, content: String.slice(inspect(signal.item), 0..42)}
  #   #
  #   # signals = Application.get_env(:ilvmx, @signals)
  #   # signals = Dict.update(signals, signal.path, [sigmap], fn signal_list ->
  #   #   List.flatten(signal_list, [sigmap])
  #   # end)
  #   # Application.put_env(:ilvmx, @signals, signals)
  #   # IO.inspect "(x-x-):CPU.install! #{inspect signals}}"
  #
  #   # message_loop(signal_agent, program, server)
  #
  #   #todo: return a UUID-based token for ownership
  #
  #   {:noreply, opts}
  # end
  
  ## Kill
  
  # @doc """
  # #todo: Kill a `signal` already in Nubspace.
  # """
  # def kill!(signal, token) do
  #   {:ok, server} = GenServer.start_link(__MODULE__, nil, debug: [])
  #   IO.inspect "(x-x-):CPU.install! {signal: #{inspect signal.path}, server: #{inspect server}}"
  #
  #   # process the signal/program
  #   GenServer.cast(server, {:kill, signal, token})
  #
  #   signal
  # end
  
  
  ## Private
  
  def message_loop(signal_agent, program \\ nil, server \\ nil) do
    receive do
    # {:boost, boost_agent, client, source} ->
    #     # # grab the two signals
    #     # boost   = Agent.get boost_agent,  fn boost  -> boost end
    #     # signal  = Agent.get signal_agent, fn signal -> signal end
    #     #
    #     # # IO.inspect "(x-x-):SignalServer.message_loop.boost:  #{inspect boost}"
    #     # # IO.inspect "(x-x-):SignalServer.message_loop.signal: #{inspect signal}"
    #     # #
    #     # #todo: exe program or otherwise pattern/match
    #     # #
    #     # # a dumb "boost" match to up the signal
    #     # Agent.update boost_agent,  fn signal -> Signal.i(signal, signal) end
    #     #
    #     # # # update our signal
    #     # Agent.update signal_agent, fn signal -> Signal.i(signal, boost) end
    #     #
    #     # # forward signal to client
    #     # if client do
    #     #   send client, {:update, boost_agent, server}
    #     # end
    #
      {_, content} -> IO.inspect "(x-x-):unknown message in signal_loop: #{ inspect content }"
    end
    
    message_loop(signal_agent, server)
  end
  

  ## GenServer Callbacks
  
  def handle_info(_message, _nil) do
    {:noreply, _nil}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
  
  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end
