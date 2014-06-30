defmodule ILVMX.Plug.Server do
  import  Plug.Conn
  use     Plug.Router
  use     Plug.Builder

  plug Plug.Static, at: "/static", from: :ilvmx
  plug :match
  plug :dispatch


  @doc """
  Web Requests from Cowboy/Plug.
  """
  def adapt(conn, []) do
    send_resp(conn, 200, Bot.prop("html/header.html") <> Bot.prop("html/footer.html"))
  end
  def adapt(conn, commands) do
    case invalid_path? commands do
      true  -> send_resp(conn, 404, "404: 02 File not found (ILvMx 4.x)")
      false -> send_resp conn, 200, Bot.prop(Path.join(commands))
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
    adapt conn, conn.path_info
  end
  
  @doc """
  Errors. Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  #todo: forward errors to the Wizard for defensive purposes.
  """
  match(_) do
    send_resp(conn, 500, "500: 5A Required system component not installed (ILvMx 4.x)")
  end
  
  @doc """
  Imported from Plug.
  https://raw.githubusercontent.com/elixir-lang/plug/master/lib/plug/static.ex
  """
  defp invalid_path?([h|_]) when h in [".", "..", ""], do: true
  defp invalid_path?([h|t]) do
    case :binary.match(h, ["/", "\\", ":"]) do
      {_, _} -> true
      :nomatch -> invalid_path?(t)
    end
  end
  defp invalid_path?([]), do: false
    
end