defmodule ILM.Mixfile do
  use Mix.Project

  def project do
    [ app: :ilvmx,
      version: "0.0.1",
      elixir: "~> 0.13.0",
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
      ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  
  # hack: 4/28/14 grab "v0.4.1" tag of Plug to work with current v0.13.0.
  defp deps do
    [
      {:exactor,                github: "sasa1977/exactor"},
      {:con_cache,              github: "sasa1977/con_cache"},
      {:ossp_uuid,              github: "yrashk/erlang-ossp-uuid"},
      {:cowboy,                 github: "extend/cowboy"},
      {:plug,                   github: "elixir-lang/plug", tag: "v0.4.1"},
      {:jsex,                   github: "talentdeficit/jsex"},
    ]
  end
end
