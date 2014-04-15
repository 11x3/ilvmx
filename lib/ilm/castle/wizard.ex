defmodule ILM.Wizard do
  
  def deflect!(bot) do
    # todo: filter/enrich/track/intercept the bot/request/data via Spells
    
    bot |> ILM.BotLab.upload!  
  end
      
end