require Logger

defmodule Castle.Plug do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  use     Jazz
  
  @parsers          [Plug.Parsers.MULTIPART, Plug.Parsers.URLENCODED]
  @upload_limit     Castle.upload_limit
  
  @moduledoc """
  Castle access for Web requests from Cowboy/Plug.
  """
  
  plug Plug.Static, at: "/static", from: :ilvmx
  plug :dispatch
  plug :match

  ## Plug 
  
  @doc "Plug: *ring*, *ring*"
  def call(conn = %Plug.Conn{path_info: []}, options) do
    send_resp conn, 200, Bot.grab(["header.html", "footer.html"])
  end
  
  def call(conn = %Plug.Conn{path_info: signal_path}, options) do
    Logger.debug "Castle.Plug: #{Path.join(signal_path)}"
    
    game conn, signal_path
  end

  @doc "Route for pushing `Item`s into Castle.Nubspace."
  def game(conn, signal_path = ["push"]) do
    #todo: secure/validate inputs
    
    # parse the http signal
    conn    = Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit)
    
    # auto-init binary items before the signal is processed
    upload  = conn.params["item"]
    item    = Item.w File.read!(upload["content"].path), upload["program"]
    signal  = Signal.set(signal_path, conn) |> Signal.boost item
    
    game_result(conn, Castle.execute(signal, conn))
  end
  
  @doc "Route for static objects."
  def game(conn, signal_path = ["obj"|unique]) do
    Logger.debug "Castle.Plug.self: #{inspect self}"
    
    obj_path = Path.join(["priv", "static"|signal_path])
    
    if File.exists?(obj_path) do
      # todo: add send_file here
      send_resp conn, 200, File.read!(obj_path)
    else  
      send_resp conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)"
    end
  end
  
  @doc "Dynamic nubspace routes."
  def game(conn, command) do
    Logger.debug "Castle.Plug.self: #{inspect self}"
    
    # always send a signal, but sometimes return an item.
    obj_path = Path.join(["priv", "static"|command])
    
    if File.exists?(obj_path) do
      Task.async fn -> Castle.ping! Signal.set Path.join(command) end
      
      # todo: add send_file here
      send_resp conn, 200, File.read!(obj_path)
    else
      game_result(conn, Castle.x!(Path.join(command), conn))
    end
  end
  defp game_result(conn, nil) do
    #todo: breakout nil results into `command` and API responses.
    #send_resp(conn, 200, "")
  
    redirect(conn, "/")
  end
  defp game_result(conn, result) when is_list(result) do
    send_resp(conn, 200, inspect(Enum.map(result, fn i -> i.content end)))
  end
  defp game_result(conn, whatever) do
    send_resp(conn, 200, inspect(whatever))
  end
  
  @doc """  
  Sends redirect response to provided url String

  ## Examples

      redirect conn, "http://elixir-lang.org"
      redirect conn, 404, "http://elixir-lang.org"

  Redirect pulled and modified from Phoenix:
  /phoenix/blob/eae9c5dfcb81875c5bcb5b2ee5bdbd5eb9898bd9/lib/phoenix/controller/connection.ex
  """
  def redirect(conn, url), do: redirect(conn, :found, url)
  def redirect(conn, status, url) do
    conn
    |> put_resp_header("Location", url)
    |> send_resp(200, url)
  end
    
    
  @doc "Initialize options"
  def init(options) do
    Logger.debug "Castle.Plug.self: #{inspect self}"
    
    #todo: self |> Castle.Game.join
    
    options
  end

  @doc "#todo: forward errors to the Wizard for defensive purposes."
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
end