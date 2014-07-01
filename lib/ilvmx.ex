# ILVMX project and all related sub directories and source code are 
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

defmodule IT do
  
  @doc """
  Imported from Plug.
  https://raw.githubusercontent.com/elixir-lang/plug/master/lib/plug/static.ex
  """
  def valid_path?([h|_]) when h in [".", "..", ""], do: false
  def valid_path?([h|t]) do
    case :binary.match(h, ["/", "\\", ":"]) do
      {_, _} -> false
      :nomatch -> valid_path?(t)
    end
  end
  def valid_path?([]), do: true
    
end
  
defmodule ILVMX do
  use Application
  
  @moduledoc """
  ILVMX: functionally minded cloud app server and exchange.
  """

  # GenSupervisor
  
  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start do
    start(nil, nil)
  end
  def start(_type, _args) do
    ILVMX.Castle.Supervisor.start_link
  end
end
