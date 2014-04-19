defmodule ILM.WebServer do
  import  Plug.Connection
  use     Plug.Router
    
  plug :match

  @doc """
  Initialize options
  """
  def init(options) do
    options
  end

  @doc """
  Web Requests from a Cowboy/Plug.
  
  # Example:
  "GET /lolnub/chat" -> "#lolnub #chat"
  """
  def call(conn, opts) do
    result = inspect(Player.arrow! Cupcake.from(conn.path_info))
    throw IO.inspect result
    
    send_resp conn, 200, "lol"
  end
  
  @doc """
  (*/*)
  """
  match route do
    # Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
    send_resp(conn, 404, "5A Required system component not installed (DOS 4.04.#{ ILM.uuid })")
  end
end