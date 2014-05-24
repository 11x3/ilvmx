defmodule Bot do
  defstruct program: nil,
            results: [],           
             errors: [],
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil

  # API

  @doc """
  Add an effect to `bot`'s results.
  """
  def effect(bot, effect) do
    %{ bot | results: Enum.concat(bot.results, [effect]) }
  end
end