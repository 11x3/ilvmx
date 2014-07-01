defmodule ILM.Mixfile do
  use Mix.Project

  def project do
    [ app: :ilvmx,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ILM, [] },
      applications: [
        :crypto,
        :ossp_uuid,
        :cowboy,
        :plug,
        :httpotion,
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
      {:cowboy,     github: "extend/cowboy"},
      {:plug,       github: "elixir-lang/plug"},
      {:ossp_uuid,  github: "yrashk/erlang-ossp-uuid", overide: false},
      {:con_cache,  github: "sasa1977/con_cache", overide: false},
      {:httpotion,  github: "myfreeweb/httpotion", overide: false},
      {:jazz,       github: "meh/jazz"},
    ]
  end
end

