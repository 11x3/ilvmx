defmodule Player do
defstruct castle: nil, # "home" castle (ie. connection to :ilvmx galaxy)
            home: nil, # "nubspace" (ie. user/nick)
         wizards: [],  # custom pipes/scripts
            bots: [],  # programs (see: bot.ex)
           polls: [],  # keyword list of okcupid-like data
          unique: nil
  
  @moduledoc """
  Us. Them. You. Me.
  """
  
  # Bot.cmd "#player #polls" do
  #   # todo: support APIs.
  # end
  
  @doc """
  Forever anon.
  """
  def anon do
    %Player{unique: ILVMX.Castle.Server.uuid}
  end
end