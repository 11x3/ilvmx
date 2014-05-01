defmodule ILM.Config do
  use Phoenix.Config.App

  config :router, port: 8080
  config :plugs, code_reload: false, consider_all_requests_local: false
end

defmodule ILM.Config.Dev do
  use ILM.Config

  config :router, port: System.get_env("PORT") || 8080
  config :plugs,  code_reload: true
  config :logger, level: :debug
end