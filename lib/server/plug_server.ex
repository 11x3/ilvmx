defmodule ILM.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  use     Jazz
  
  @parsers [Plug.Parsers.MULTIPART, Plug.Parsers.URLENCODED]
  @upload_limit ILM.Castle.upload_limit
  
  @moduledoc """
  Web Requests from Cowboy/Plug.
  """
  
  plug Plug.Static, at: "/static", from: :ilvmx
  plug :dispatch
  plug :match

  @doc """
  (*/*)
  Plug: *ring*, *ring*
  """
  def call(conn, opts) do
    adapt(conn, conn.path_info)
  end
  
  
  @doc """
  (*/*)
  ILvMx: hello?
  """
  def adapt(conn, []) do
    ## Splash
    
    adapt(conn, ["app"])
  end
  def adapt(conn, ["app"]) do
    ## App
    
    send_resp conn, 200, Bot.prop "index.html"
  end
  def adapt(conn, commands) do
    ## Files/Items/Object
    cmd_path = Path.join(["priv", "static"|commands])
    unless Wizard.valid_path?(commands) do
      send_resp conn, 404, "404:1 File not found (ILM.Plug.Server)"
    else
      if File.exists?(cmd_path) do
        send_resp conn, 200, File.read!(cmd_path)
      else
        signal = Signal.x self, Path.join(commands), Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit)
        
        send_resp(conn, 200, inspect(signal.items))
      end
    end
  end
  
  
  @doc """
  Initialize options
  """
  def init(options), do: []

  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
end