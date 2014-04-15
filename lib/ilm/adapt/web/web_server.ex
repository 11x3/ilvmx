defimpl JSEX.Encoder, for: Nub do
  def json(record) do
    [:start_object, 
      "galaxy", record.galaxy, 
      "castle", record.castle, 
      "unique", record.unique, 
      "domain", record.domain, 
      "system", record.system, 
      "module", record.module, 
      "member", record.member, 
      "method", record.method, 
      :end_object]
  end
end

defmodule ILM.WebServer do
  import  Plug.Connection
  use     Plug.Router
  
  alias Cupcake
  
  plug :match
  #plug :dispatch

  @doc """
  Initialize options
  """
  def init(options) do
    options
  end

  @doc """
  New requests from a Plug app.
  
  /ilm/(nil=get/set/exe)/commands/arguments
  
  event = [
    content = Effect[ 
      [:emit, :json, "/objects/1.json"]
    ]
    source  = Bot["#ilm #etc"]
  ]
  """
  def call(conn, opts) do
    # drop an empty list so that the first tag in the nubspace will also
    # get picked up by the Enum.join
    # event = Bot.get Frosting.from(conn.path_info)
    # # todo: capture the bot, and don't send until we get an event back 
    # send_resp(conn, 200, "[event: #{ event.unique }]")
    result = inspect Bot.get(Frosting.from(conn.path_info))
    
    send_resp(conn, 200, result)
  end
  
  @doc """
  (*/*)
  """
  match route do
    # Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
    send_resp(conn, 404, "5A Required system component not installed (DOS 4.04.#{ ILM.uuid })")
  end
end