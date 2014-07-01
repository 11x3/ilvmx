defmodule Wizard do
  @moduledoc """
  Wizards protect and guard the Castle.
  
  They filter/enrich/track/intercept all events/requests/data.
  """
  
  @doc """
  Ask the Wizard (nicely) to process an event.
  """
  def please?(event) do
    event |> ILM.Castle.Wizard.Server.please?
  end
end