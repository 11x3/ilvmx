# ILvMx project and all related sub directories and source code are 
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
  use Application.Behaviour

  @cache :cache
  @epoch :epoch

  @moduledoc """
  ILM: functionally minded cloud app server and exchange.
  """
  # API/Sugar
  
  @doc """
  #lolnub #mike what's up?
  """
  def magic!(castle, player, bot) do
    Player.p1(player).arrow!(bot) |> Castle.door("#lolnub")
  end

  @doc """
  Return the ILM.castle.
  """
  def castle do
    Process.whereis :castle
  end

  @doc """
  Return an ILM.uuid.
  """
  def uuid do
    :ossp_uuid.make(:v4, :text) 
  end
  
  @doc """
  Return the regex that matches ILM.uuids
  """
  def uuid_regex do
    ~r/[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}/i
  end

  @doc """
  Return the app cache.
  """
  def cache do
    store = Process.get @cache
    if !store do
      store = ConCache.start_link(
        touch_on_read: true,
        ttl: :timer.seconds(0)
      )
      
      Process.put @cache, store
    end
    store
  end
  
  # GenSupervisor
  
  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start do
    start(nil, nil)
  end
  def start(_type, _args) do
    # Private
    ILM.cache
    
    # Database
    Amnesia.Schema.create
    Amnesia.start    
    Db.create(disk: [node])
    Db.wait

    # UUID/crypto
    :application.start(:crypto)
    
    ILM.Supervisor.start_link
  end
end
