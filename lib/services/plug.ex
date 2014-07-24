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
  
  def call(conn, options) do
    #IO.inspect "(x-x-) Plug: >#{ Path.join([[]|conn.path_info]) }<"
    
    cmd_path = Path.join(["priv", "static"|conn.path_info])
    
    if File.exists?(cmd_path) do
      send_resp conn, 200, File.read!(cmd_path)
    end
    
    # accept, then spawn
    # Signal.x conn, conn.path_info, Program.cmd fn signal ->
    #   chunk(conn, inspect(signal.items))
    # end

    send_chunked(conn, 200)
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