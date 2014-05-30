defmodule Prop do
  
  @moduledoc """
  Take objects from The World, oh our dear World.
  """
  @moduledoc """
  Place objects into The World, oh our dear World.
  """

  @doc """
  Read a file from the file system.
  # todo: secure the path, yes yes yes
  """
  def static(path) do
    File.read!(path)
  end
  
  # def drop(:static, content) do
  #   # todo: write binary to public static objects
  # end
  
  @doc """
  Read a file from the file system.
  # todo: secure the path, yes yes yes
  """
  def web(path) do
    HTTPotion.get(path).body
  end
  # todo: add web REST support

end
