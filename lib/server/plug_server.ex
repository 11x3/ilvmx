use Jazz
import IT

defmodule ILM.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder

  plug Plug.Static, at: "/static", from: :ilvmx
  plug :dispatch
  plug :match

  @doc """
  Web Requests from Cowboy/Plug.
  """
  def adapt(conn, []) do
    send_resp(conn, 200, Bot.prop("html/app.html"))
  end
  def adapt(conn, ["api", "set"]) do
    conn = Plug.Parsers.call(conn, parsers: [Plug.Parsers.MULTIPART], limit: 8_000_000)
      
    item = conn.params["item"]
    nub  = conn.params["nubspace"]
    
    unless IT.valid_path?(nub) do
      send_resp conn, 404, "404: 03 File not found (ILvMx 4.x)"
    else
      send_resp conn, 200, inspect(Bot.set(nub, File.read!(item.path)))
    end
  end
  def adapt(conn, ["api", "get", nubspace]) do
    unless effect = Bot.get("##{ nubspace }") do
      send_resp conn, 404, "404: 01 File not found (ILvMx 4.x)"
    else 
      {:ok, json} = JSON.encode(effect.content)
      send_resp conn, 200, json
    end
  end
  def adapt(conn, commands) do
    unless item = Bot.prop(Path.join(commands)) do
      send_resp conn, 404, "404: 02 File not found (ILvMx 4.x)"
    else
      send_resp conn, 200, item
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
    Player.arrow! do
      adapt(fetch_params(conn), conn.path_info)
    end
  end
  
  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
      
end