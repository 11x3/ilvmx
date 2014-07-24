defmodule ILM.Services.Plug do
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
  
  
  ## Plug 
  
  @doc "Plug: *ring*, *ring*"
  def call(conn = %Plug.Conn{path_info: []}, options) do
    send_resp conn, 200, Bot.take "index.html"
  end
  
  def call(conn = %Plug.Conn{path_info: signal_path}, options) do
    IO.inspect "(x-x-) Plug: >#{inspect signal_path}<"
    
    cmd_path = Path.join(["priv", "static"|signal_path])
    
    if File.exists?(cmd_path) do
      send_resp conn, 200, File.read!(cmd_path)
    else
      send_resp conn, 200, inspect(Signal.x(conn, signal_path, conn.params).items)
    end
  end

  @doc """
  Initialize options
  """
  def init(options) do
    options
  end

  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
end