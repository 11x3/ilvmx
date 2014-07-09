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
  
  #plug Plug.Static, at: "/static", from: :ilvmx
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
  def adapt(conn, ["app"|commands]) do
    ## Signals
    
    cmd_path = Path.join commands
    unless Wizard.valid_path?(cmd_path) do
      send_resp conn, 404, "404:1 File not found (ILM.Plug.Server)"
    else
      # exe the signal
      signal = Signal.x(self(), commands, Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit))
            
      send_resp(conn, 200, inspect(signal.effects))
    end
  end
  def adapt(conn, ["api"|commands]) do
    ## Signals

    cmd_path = commands |> Path.join
    unless Wizard.valid_path?() do
      send_resp conn, 404, "404:1 File not found (ILM.Plug.Server)"
    else
      # exe the signal
      signal = Signal.x(self(), commands, Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit))
            
      send_resp(conn, 200, inspect(signal.effects))
    end
  end  
  def adapt(conn, commands) do
    ## Files/Items/Objects
    
    cmd_path = Path.join(["priv", "static", "app"|commands])
        
    unless Wizard.valid_path?(cmd_path) and File.exists?(cmd_path) do
      send_resp conn, 404, "404:3 File not found (ILM.Plug.Server)"
    else
      if File.dir?(cmd_path) do
        #todo: read the nubspace
        []
      else
        send_resp conn, 200, File.read!(cmd_path)
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