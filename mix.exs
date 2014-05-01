Code.ensure_loaded?(Hex) and Hex.start

defmodule ILM.Mixfile do
  use Mix.Project

  def project do
    [ app: :ilvmx,
      version: "0.0.1",
      elixir: "~> 0.13.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ILM, [] },
      applications: [
        :ossp_uuid,
        :httpotion,
        :cowboy,
      ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  
  defp deps do
    [
      {:cowboy,                 github: "extend/cowboy"},
      {:ossp_uuid,              github: "yrashk/erlang-ossp-uuid"},
      {:con_cache,              github: "sasa1977/con_cache"},
      {:amnesia,                github: "meh/amnesia" },
      {:timex,                  github: "bitwalker/timex"},
      {:httpotion,              github: "myfreeweb/httpotion"},
    ]
  end
end
