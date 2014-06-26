defmodule ILVMX.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder

  plug Plug.Static, at: "/static", from: :ilvmx
  plug :match
  plug :dispatch
    
  @doc """
  Initialize options
  """
  def init(options), do: options
    
  @doc """
  (*/*)
  Catch all.
  """
  def call(conn, opts) do
    adapt conn, conn.path_info
  end

  @doc """
  Web Requests from Cowboy/Plug.
  """
  def adapt(conn, []) do
    send_resp conn, 200, Bot.prop "app/index.html"
  end
  def adapt(conn, ["api", commands]) do
    send_resp conn, 200, inspect(commands)
  end
  def adapt(conn, commands) do
    # todo: secure commands
    send_resp conn, 200, Bot.prop(Path.join(commands))
  end
  
  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "5A Required system component not installed (ILvMx 4.04)")
  end
end