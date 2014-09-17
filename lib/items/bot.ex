require Logger
use Jazz

defmodule Bot do
  use GenServer
  
  @moduledoc """
  Bots are direct-level workers of the ILvMx universe.
  
  Bots are the foundation of the Cakedown (or whatever it 
  eventually becomes called..) markup syntax.
  
  All public `Bot` functions work with user generated content,
  and so should be programmed as hostile safe. 
  
  Because Bots are stateless agents that work with side effects,
  they mostly revolve around a small set of concepts:
  
  Bot = [
    World,
    Castle.Nubspace,
    Item,
    File
  ]
  
  All processes should consider using Bots to interact with
  as primitives.
  """
  
  
  ## World API (readin the webs)

  @doc "Read a file from the internet."
  def web(path) do
    #todo: add a SpiderBot server and distribute these requests
    if Castle.Wizard.valid_path?(path) do
      HTTPotion.get(path).body
    end
  end

  
  ## Item/Nubspace API push/pull data+items (nubspace = cooking with love)

  @doc "Return a list of `nubspace` items."
  def pull(nubspace = []) do
    pull "signals"
  end
  def pull(nubspace) when is_list(nubspace) do
    pull Path.join(nubspace)
  end
  def pull(nubspace) when is_binary(nubspace) do
    # check
    meta_path  = Path.join(["priv/static/nub", nubspace, "meta"])

    unless Castle.Wizard.valid_path?(nubspace) and File.exists?(meta_path) do
      # todo: return an error
      []
    else
      JSON.decode!(File.read!(meta_path))
    end
  end


  ## File API (file system level blobs)

  @doc "Place objects into The World, oh our dear World."
  def make(data, static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    
    unless Castle.Wizard.valid_path?(prop_path) do
      nil
    else
      Task.async(fn -> File.write!(prop_path, data) end) |> Task.await
      
      data
    end
  end
  
  @doc "Take files from priv/static."
  def grab(static_relative_path_list) when is_list(static_relative_path_list) do
    (static_relative_path_list |> Enum.map &(grab &1)) |> :binary.list_to_bin
  end
  def grab(static_relative_path) do
    prop_path = Path.join("priv/static", static_relative_path)
    unless Castle.Wizard.valid_path?(prop_path) and File.exists?(prop_path) do
      nil
    else
      File.read! prop_path
    end
  end
  
  
  ## Callbacks
  
  
  # @doc """
  # Execute a `nubspace` with `cupcake`.
  # # todo: make this non-brute force
  # Beam or lift a Bot (in a reactive style), onto a Nubspace to produce an
  # FRP-like signal. todo: add the :epoch support back in.
  #
  # Or.. beam a Bot up into the Nubspace where it may long live the rest of its
  # days. Or at least until it discovers a tiny civilization has developed on
  # the rear, and then God and friends save it. The End.
  # """
  # def jump!(bot, nubspace) do
  #   nub = pull! nubspace
  #
  #   bot.results(nub.cupcakes |> Enum.map fn cake ->
  #     if is_function cake do
  #       bot.results(Enum.concat(bot.results, [cake.(bot, bot.cupcake)]))
  #     end
  #   end)
  # end
  
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
    link = {:ok, bot} = GenServer.start_link(Bot, default)
    
    Logger.debug "Bot: #{inspect bot}"

    link
  end
end