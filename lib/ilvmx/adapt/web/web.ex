defmodule ILM.Adapt.Web do
  import  Plug.Conn
  use     Plug.Builder
  
  plug Plug.Static, at: "/static", from: :ilvmx
  plug :pass
  
  @doc """
  Initialize options
  """
  def init(options), do: options
  
  @doc """
  Web Requests from Cowboy/Plug.
  """
  defp pass(conn, _) do
    send_resp conn, 200, Castle.door
  end
  
  @doc """
  (*/*)
  Props to http://stanislavs.org/helppc/dos_error_codes.html for the DOS codes
  """
  defp not_found(conn, _) do
    send_resp conn, 404, "5A Required system component not installed (ILM 4.04)"
  end
end