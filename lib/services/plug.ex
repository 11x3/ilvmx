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
    send_resp conn, 200, Bot.take(["header.html", "footer.html"])
  end
  
  def call(conn = %Plug.Conn{path_info: signal_path}, options) do
    Logger.debug "(x-x-) Plug: #{inspect Path.join(signal_path)}"
    
    hello conn, signal_path
  end

  
  @doc "Route for static objects."
  def hello(conn, signal_path = ["obj"|unique]) do
    obj_path = Path.join(["priv", "static"|signal_path])
    
    if File.exists?(obj_path) do
      # todo: add send_file here
      send_resp conn, 200, File.read!(obj_path)
    else
      send_resp conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)"
    end
  end
  
  @doc "Dynamic nubspace routes."
  def hello(conn, nubspace) do
    # always send a signal, but sometimes return an item.
    obj_path = Path.join(["priv", "static"|nubspace])
    
    if File.exists?(obj_path) do
      #Task.async fn -> Castle.x Path.join(nubspace) end
      
      # todo: add send_file here
      send_resp conn, 200, File.read!(obj_path)
    else
      hello_result(conn, Castle.x(Path.join(nubspace)))
    end
  end
  defp hello_result(conn, items) do    
    send_resp conn, 200, (Bot.take("header.html") <> inspect(items) <> Bot.take("footer.html"))
  end
  
  
  @doc "Initialize options"
  def init(options) do
    
    options
  end

  @doc "#todo: forward errors to the Wizard for defensive purposes."
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
end