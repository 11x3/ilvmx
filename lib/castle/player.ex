defmodule Player do
   defstruct ownership: nil, # an Item "home" on a castle/nubspace (ie. /players/nick)
                 items: [],  # custom pipes/scripts
  #            #  bots: [],  # active bots (see: bot.ex)
  #            # polls: nil,  # keyword list of okcupid-like data
  #            # clans: nil,
  #            # banks: %{cash: nil, karma: nil, dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"},
                source: nil,
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
      source: self,
      ownership: secret
    }
  end
  
  ## Instance
  
  @doc "Add `items` to `signal`."
  def items(player, items) when is_list(items) do
    %{player| items: List.flatten([player.items|items]) }
  end
  def items(player, item) do
    %{player| items: List.flatten([player.items|[item]]) }
  end
  
end