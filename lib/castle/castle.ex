defmodule Castle do
  
  @epoch :epoch

  @moduledoc """
  ILM takes place in `Castle` servers in the Great Kingdom of Nub. Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILM exchange.

  Castle [
    Game [
      Wizard/Players/Services
    ],
    CPU [
      Signals/Programs/Items/Bots
    ],
  ]
  """
  
  ## System

  def agent do
    Application.get_env :ilvmx, :castle_agent
  end

  @doc "Return all :install'ed `Signals`s."
  def signal do
    Signal.m
  end
  
  
  ## API

  @doc "Beam `Signal`s into the `Castle`."
  def beam!(signal) do
    #todo: readd: duration \\ 1000, auto \\ true
    IO.inspect "Castle.beam!: ##{signal.path}"
    
    Castle.CPU.install!(signal)
  end
  
  @doc "Ping a `signal_path` of the Castle.Nubspace."
  def ping!(signal) do
    IO.inspect "Castle.beam!: ##{signal.path}"
    
    Castle.CPU.install!(signal)
  end
  

  ## Public
  
  @doc "ILvMx network exchange."
  def galaxy do
    "#ilvmx"
  end
  
  @doc "Castle name."
  def name do
    "#lolnub"
  end
  
  @doc "Return an UUID."
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  
  ## Misc.
  
  @doc "Return the regex that matches Castle.uuids"
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc "Return the general max size of an upload."
  def upload_limit do
    8_000_000
  end
  
end