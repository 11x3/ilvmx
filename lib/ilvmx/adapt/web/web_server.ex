defmodule ILM.Adapt.WebServer do
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
  Web Requests from Cowboy/Plug.
  """
  def call(conn, opts) do
    throw IO.inspect conn.path_info
    
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