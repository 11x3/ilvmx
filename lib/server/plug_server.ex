use Jazz

defmodule ILM.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  
  
  @moduledoc """
  Web Requests from Cowboy/Plug.
  """
  
  plug Plug.Static, at: "/static", from: :ilvmx
  plug :dispatch
  plug :match

  @doc """
  (*/*)
  Requests from `Plug` will return an %Signal{}
  """
  def call(conn, opts) do
    # Async requests
    signal = Signal.w(conn, conn.path_info)

    unless Wizard.valid_path?(signal.signal) do
      send_resp conn, 404, "404: File not found (ILM.Plug.Server)"
    else
      # Create the event with the unfetched 'conn' + signal '/api/etc'      
      Task.async(fn -> 
        client = Plug.Parsers.call(conn, parsers: [Plug.Parsers.MULTIPART], limit: ILM.Castle.upload_limit)
        
        %Signal{signal| content: client.params} |> Wizard.please?
      end)
      
      # return the event.uuid directly to the client      
      send_resp(conn, 200, JSON.encode!(%{ signal: signal.unique }))
    end
  end

  # def api(conn, ["api", "set"]) do
  #   # adapt HTTP to program
  #   # exe the program
  #   # set the object
  #   # set the binary
  # end  

  @doc """
  Initialize options
  """
  def init(options), do: []

  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end

end