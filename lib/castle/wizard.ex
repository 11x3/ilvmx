defmodule Castle.Wizard do
  use GenServer

  @moduledoc """
  Wizards filter/enrich/track/intercept Castle Signals.
  # todo: add review/callbacks api
  """
  
  @doc """
  Ask the Wizard (nicely) to process a `Signal`.
  """
  def please?(signal) do
    signal |> review?
  end
  
  
  @doc "Stub :before `Signal` traffic review."
  def review?(signal = %Signal{item: item = %Item{content: %{"binary" => %Plug.Upload{} }}}) do
    upload = item.content["binary"]
    # hack: auto-init binary items before the signal is processed    
    review?(%{signal| item: %{item| kind: upload.content_type, content: File.read!(upload.path) }})
  end
  def review?(signal) do
    
    signal
  end
  
  
  @doc """
  Stub :after `Signal` traffic filters.
  """
  def filter?(signal) do
    # todo: add callbacks api

    signal
  end

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

  # GenServer Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end
end