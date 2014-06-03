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
    send_resp(conn, 200, adapt(conn, conn.path_info))
  end

  @doc """
  Web Requests from Cowboy/Plug.
  """
  def adapt(conn, []) do
    Bot.prop("index.html")
  end
  def adapt(conn, commands) do
    # todo: secure commands
    Bot.prop(Path.join(commands))
  end

  @doc """
  Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  """
  match _ do
    send_resp conn, 404, "5A Required system component not installed (ILvMx 4.04)"
  end
end