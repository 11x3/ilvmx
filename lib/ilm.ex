# ILM/ILvMx projects and all related sub directories and source code are 
# Copyright 2014 lolnub.com developers AND licensed as open source:
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
  
defmodule ILM do
  use Application
  
  @moduledoc """
  ILM a functionally minded cloud app server and #virtual module exchange.
  """

  ## API
  
  def signals_agent do
    Application.get_env :ilvmx, :signals
  end
  
  def signals do
    Agent.get ILM.signals_agent, fn signals -> signals end
  end
  
  def signals(path, sigmap) do
    Agent.update ILM.signals_agent, fn signals -> 
      Dict.update signals, path, [sigmap], &(List.flatten signals[path], &1)
    end
  end
  
  # GenSupervisor
  
  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start do
    IO.inspect "(x-x-) #ilvmx."
    
    # Setup dynamic castle signals.
    {:ok, signal_agent} = Agent.start_link(fn -> %{} end)
    Application.put_env(:ilvmx, :signals, signal_agent)
    
    start(nil, nil)
  end
  def start(_type, _args) do
    ILM.Castle.Supervisor.start_link
  end
end
