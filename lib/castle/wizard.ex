defmodule Wizard do
  @moduledoc """
  Wizards filter/enrich/track/intercept Castle Signals.
  """

  @doc """
  Imported from Plug.
  https://raw.githubusercontent.com/elixir-lang/plug/master/lib/plug/static.ex
  
  Returns false for invalid paths.
  """
  def valid_path?(path) when is_binary(path) and path in [".", "..", ""], do: false
  def valid_path?([h|_]) when h in [nil, "..", "", "\\", " "], do: false
  def valid_path?([h|t]) do
    case :binary.match(h, ["/", "\\", ":"]) do
      {_, _} -> false
      :nomatch -> valid_path?(t)
    end
  end
  def valid_path?(_), do: true

end