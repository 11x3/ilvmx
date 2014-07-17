defmodule ILM.Servers.Plug do
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
  def call(conn, opts) do
    IO.inspect "(x-x-) Plug: #{ Path.join([[]|conn.path_info]) }"
    
    hello(conn, conn.path_info)
  end
  
  ## Custom
  
  @doc "(x-x-): hello?"
  def hello(conn, []) do
    ## Splash
        
    hello(conn, ["app"])
  end
  def hello(conn, ["app"]) do
    ## App
    
    send_resp conn, 200, Bot.take "index.html"
  end
  def hello(conn, commands) do
    ## Files/Items/Object
    cmd_path = Path.join(["priv", "static"|commands])
    
    unless ILM.Castle.Wizard.valid_path?(commands) do
      send_resp conn, 404, "(x-x-) 404:1 File not found"
    else
      if File.exists?(cmd_path) do
        send_resp conn, 200, File.read!(cmd_path)
      else
        # kickoff
        signal_path   = Path.join(commands)
        signal_params = Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit)
        
        signal = Signal.x self, signal_path, signal_params
        
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