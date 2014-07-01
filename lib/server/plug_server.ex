use Jazz
import IT

defmodule ILM.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder

  plug Plug.Static, at: "/static", from: :ilvmx
  plug :dispatch
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  @doc """
  Web Requests from Cowboy/Plug.
  """
  def adapt(conn, []) do
    send_resp(conn, 200, Bot.prop("html/header.html") <> Bot.prop("html/footer.html"))
  end
  def adapt(conn, ["api", "get", nubspace]) do
    case effect = Bot.get("##{ nubspace }") do
      nil -> send_resp conn, 404, "404: 01 File not found (ILvMx 4.x)"
      _   -> 
        {:ok, json} = JSON.encode(effect.content)
        send_resp conn, 200, json
    end
  end
  def adapt(conn, commands) do
    case item = Bot.prop(Path.join(commands)) do
      nil -> send_resp conn, 404, "404: 02 File not found (ILvMx 4.x)"
      _   -> send_resp conn, 200, item
    end
  end

  @doc """
  Initialize options
  """
  def init(options), do: options
    
  @doc """
  (*/*)
  Catch all.
  """
  def call(conn, opts) do
    adapt(fetch_params(conn), conn.path_info)
  end
  
  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
      
end