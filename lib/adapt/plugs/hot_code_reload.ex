defmodule Plugs.HotCodeReload do
  
  import Plug.Conn
  # 
  # # Pulled from: https://github.com/sugar-framework/plugs
  # 
  # @behaviour Plug
  # 
  def init(opts), do: opts
  
  def call(conn, _) do
    conn
  end
  
  # def call(conn, _) do
  #   case reload(Mix.env) do
  #     :ok -> 
  #       location = "/" <> Enum.join conn.path_info, "/"
  #       conn
  #         |> put_resp_header("Location", location) 
  #         |> send_resp_if_not_sent(302, "")
  #     _   -> conn
  #   end
  # end
   
  # # Private
  # 
  # defp reload(:dev) do 
  #   Mix.Tasks.Compile.Elixir.run([])
  # end
  # defp reload(_), do: :noreload
  # 
  # defp send_resp_if_not_sent(conn, status, body) do
  #   unless conn.state == :sent do
  #     conn |> send_resp(status, body)
  #   end
  # end
  
end