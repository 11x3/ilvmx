defmodule ILvMx.Config do
  config :router, port: System.get_env("ILVMX_PORT") || 8080
  config :plugs, code_reload: true, consider_all_requests_local: false
end

defmodule ILvMx.Config.Dev do
  use ILvMx.Config

  config :router, port: System.get_env("ILVMX_PORT") || 8080
  config :plugs,  code_reload: true
  config :logger, level: :debug
end
