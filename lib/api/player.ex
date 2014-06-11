defmodule Player do
defstruct castle: nil, # "home" castle (ie. connection to :ilvmx galaxy)
            home: nil, # "nubspace" (ie. user/nick)
        programs: [],  # custom pipes/scripts
            bots: [],  # active bots (see: bot.ex)
           polls: nil,  # keyword list of okcupid-like data
           clans: nil,
           banks: %{cash: nil, karma: nil, dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"},
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
  Send a one-way `Event` to the `Castle`.
  """
  def arrow!(program) do
    Event.w(program, anon!) |> Wizard.please?
  end
  
  @doc """
  Send an `Event` and wait for the `Castle` to respond.
  """
  def dove!(program) do
    Event.w(program, anon!) |> Wizard.please?
  end
  
end