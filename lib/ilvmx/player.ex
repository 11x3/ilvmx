defmodule Player do
   defstruct player: nil, # an Item "home" on a castle/nubspace (ie. /players/nick)
  #            # items: [],  # custom pipes/scripts
  #            #  bots: [],  # active bots (see: bot.ex)
  #            # polls: nil,  # keyword list of okcupid-like data
  #            # clans: nil,
  #            # banks: %{cash: nil, karma: nil, dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"},
             unique: nil

  import Item

  @moduledoc """
  Us. Them. You. Me.
  """

  @doc """
  Forever anon.
  """
  def anon! do
    %Player{}
  end
end