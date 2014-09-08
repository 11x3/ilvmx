defmodule Castle.Game.Plug do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  use     Jazz
  
  @parsers          [Plug.Parsers.MULTIPART, Plug.Parsers.URLENCODED]
  @upload_limit     Castle.upload_limit
  
  @moduledoc """
  Web Requests from Cowboy/Plug.
  
  #todo: register with the arcade to receive signals
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
    IO.inspect "(x-x-) Castle.Game.Plug: #{inspect signal_path}"
    
    hello conn, signal_path
  end

  
  ## Objects
  
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
  
  
  ## Dynamic
  
  @doc "Dynamic nubspace routes."
  def hello(conn, nubspace) do
    # always send a signal, but sometimes return an item.
    
    signal = Signal.m(nubspace, conn.params) 
    
    Castle.Game.host! "#{signal.unique}/commit", Program.cmd fn signal ->
      if length(signal.items) > 0 do
        send_resp conn, 200, inspect(signal.items)
      else
        obj_path = Path.join(["priv", "static"|nubspace])
      
        if File.exists?(obj_path) do
          # todo: add send_file here
          send_resp conn, 200, File.read!(obj_path)
        else
          send_resp conn, 404, inspect(signal.items)
        end
      end
    end
    
    Castle.Game.step! signal
  end
  
  
  @doc """
  Initialize options
  """
  def init(options) do
    
    options
  end

  @doc """
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
end