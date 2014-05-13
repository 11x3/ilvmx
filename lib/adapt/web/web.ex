defmodule ILM.Adapt.Web do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  
  plug Plug.Static, at: "/static", from: :ilvmx
  
  plug :match
  plug :dispatch
  
  # Cache the header/footer so we only generate the inner content *holydiver* 
  @header Prop.static "priv/static/html/header.html"
  @footer Prop.static "priv/static/html/footer.html"
  
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
  def adapt(conn, ["ilvmx"]) do    
    (@header <> Prop.static("priv/static/html/app.html") <> @footer)
  end
  def adapt(conn, ["static"|path_components]) do
    Prop.static Path.join(["priv/static"|path_components])
  end
  def adapt(conn, commands) do
    Bot.exe(commands)
  end
  
  @doc """
  Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  """
  match _ do
    send_resp conn, 404, "5A Required system component not installed (ILvMx 4.04)"
  end
end