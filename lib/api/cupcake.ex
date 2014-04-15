defmodule Cupcake do
  
  @moduledoc """
  Cupcake's big top idea is to define an entire cloud app, in an easy enough 
  way to type and code inside a <textarea> or be sent via SMS or through any 
  number of services. You should be able to develop an entire cloud app in 
  an ASCII and humane-level language in less than a minute. Assume other roles 
  are in place (accounts, funds, network, etc) and the goal is to be able to 
  dev an internet wide ILM app on a phone, deploy with a single TXT message or 
  request and it'll do the right thing and your cash/karma will be accounted
  for correctly. :D
  """
  
  @doc """  
  Create Cupcake from various commands. 
  """
  def from(command) when is_binary(command) do
    String.replace("##{ command }", "/", "")
  end
  
  def from(commands) when is_list(commands) do
    commands = commands |> Enum.map fn s -> "##{ s }" end
    list_to_bitstring commands
  end
  
end