defmodule ILM.WebServer do
  import  Plug.Connection
  use     Plug.Router
  
  alias Cupcake
  
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

  # Arrow:
  event = [
    content = Effect[ 
      [:emit, :json, "/objects/1.json"]
    ]
    source  = Bot["#ilm #etc"]
  ]
  
  # Dove:
  bot = [
    ...
  ]
  """
  def call(conn, opts) do    
    # conn = conn.resp_content_type("text/event-stream")
    # conn = conn.send_chunked(200)
    # 
    # iterator = File.iterator!("#{ conn.params[:story_name] }.txt")
    # 
    # 
    # Enum.each iterator, fn(line) ->
    #   { :ok, conn } = conn.chunk "data: #{ }\n"
    #   await conn, 1000, on_wake_up(&1, &2), on_time_out(&1)
    # end
    # 
    # result = inspect

    conn
  end
  
  @doc """
  (*/*)
  """
  match route do
    # Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
    send_resp(conn, 404, "5A Required system component not installed (DOS 4.04.#{ ILM.uuid })")
  end
end