defmodule ILM.WebServer do
  import  Plug.Connection
  use     Plug.Router
  
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
  """
  def call(conn, opts) do
    # drop an empty list so that the first tag in the nubspace will also
    # get picked up by the Enum.join
    nubspace = "#" <> (conn.path_info |> List.flatten |> Enum.join " #")
    
    # make bot
    # todo: make it for real
    bot = Bot.exe ILM.Nubspace.get nubspace
    
    # todo: capture the bot, and don't send until we get an event back 
    # from :emit stage
    send_resp(conn, 200, "[event: \"#{ bot.unique }\"]")
  end
  
  @doc """
  (*/*)
  """
  match route do    
    # Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
    send_resp(conn, 404, "5A Required system component not installed (DOS 4.04.#{ ILM.uuid })")
  end
end