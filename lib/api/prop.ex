defmodule Prop do
  @moduledoc """
  A helper module to take objects from The World.
  """
  
  @doc """
  Read a file from the file system.
  # todo: secure the path, yes yes yes
  """
  def static(path) do
    File.read!(path)
  end
  
  # @doc """
  # Read a file from the file system.
  # # todo: secure the path, yes yes yes
  # """
  # def get() do
  
  # def web(uri, method, opts) do
    
  # def email(address, subject, message, opts) do
    
  # def tweet(query) do
  # def tweet(account, auth, message)
  
  # def crawl(uris) do
  
  # def join(rooms) do
    
  # def imgur(path) do  
  
end