defmodule Player do
   defstruct  ownership: nil, # an Item "home" on a castle/nubspace (ie. /players/nick)
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
  
  ## Player API
  
  def start(secret \\ nil) do
    Player.anon!(secret)
  end
  
  @doc """
  Forever anon.
  """
  def anon!(secret \\ nil) do
    %Player{
      ownership: secret
    }
  end
end