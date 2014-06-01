defmodule Player do
defstruct castle: nil, # "home" castle (ie. connection to :ilvmx galaxy)
            home: nil, # "nubspace" (ie. user/nick)
        programs: [],  # custom pipes/scripts
            bots: [],  # active bots (see: bot.ex)
           polls: [],  # keyword list of okcupid-like data
           clans: [],
          unique: nil
  
  @moduledoc """
  Us. Them. You. Me.
  """

  @doc """
  Forever anon.
  """
  def anon! do
    %Player{
      castle: ILVMX.Castle.Server.name,
        home: "#anon",
      unique: ILVMX.Castle.Server.uuid
    }
  end
  
  @doc """
  Send a one-way message to the `Castle`.
  """
  def arrow!(program) do
    Event.w(program, anon!) |> Wizard.please? 
  end
end