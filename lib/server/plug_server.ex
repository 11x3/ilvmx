use Jazz

defmodule ILM.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder
  
  @parsers [Plug.Parsers.MULTIPART, Plug.Parsers.URLENCODED]
  @upload_limit ILM.Castle.upload_limit
  
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
    signal = Signal.m(conn, conn.path_info, Plug.Parsers.call(conn, parsers: @parsers, limit: @upload_limit))
    
    unless Wizard.valid_path?(signal.path) do
      send_resp conn, 404, "404: File not found (ILM.Plug.Server)"
    else
      # Create the event with the 'conn' + signal '/api/etc'
      Task.async(fn -> signal |> ILM.Castle.push! end)

      # return the signal info directly to the client      
      send_resp(conn, 200, JSON.encode!(%{signal: signal.path, unique: signal.unique, effects: signal.effects}))
    end
  end

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