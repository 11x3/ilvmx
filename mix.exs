defmodule ILM.Mixfile do
  use Mix.Project

  def project do
    [ app: :ilvmx,
      version: "0.0.1",
      elixir: "~> 0.12.5",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { ILM, [] },
      applications: [
        :ossp_uuid,
        :cowboy,
        :plug,
        :httpotion
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
      {:con_cache,              github: "sasa1977/con_cache"},
      {:ossp_uuid,              github: "yrashk/erlang-ossp-uuid"},
      {:cowboy,                 github: "extend/cowboy"},
      {:plug,                   github: "elixir-lang/plug"},
      {:httpotion,              github: "myfreeweb/httpotion"},
      {:otp_dsl,                github: "pragdave/otp_dsl"},
    ]
  end
end
