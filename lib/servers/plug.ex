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

  @doc "Plug: *ring*, *ring*"
  def call(conn, opts) do
    hello(conn, conn.path_info)
  end
  
  
  @doc "(x-x-):hello?"
  def hello(conn, []) do
    ## Splash
    IO.inspect "(x-x-) Plug: #{ inspect self }"
    
    hello(conn, ["app"])
  end
  def hello(conn, ["app"]) do
    ## App
    
    send_resp conn, 200, Bot.prop "index.html"
  end
  def hello(conn, commands) do
    ## Files/Items/Object
    cmd_path = Path.join(["priv", "static"|commands])
    
    unless Wizard.valid_path?(commands) do
      send_resp conn, 404, "(x-x-) 404:1 File not found"
    else
      if File.exists?(cmd_path) do
        send_resp conn, 200, File.read!(cmd_path)
      else
        # kickoff
        signal_path   = Path.join(commands)
        signal_params = Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit)
        
        Signal.x self, signal_path, signal_params
        
        receive do
          {:signal, signal} -> send_resp(conn, 200, inspect(signal))
        after
          8_000 -> send_resp(conn, 408, "(x-x-) 408:1 Remote computer not listening")
        end
        
        conn
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