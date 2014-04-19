defmodule Wizard do
  
  def react!(bot) do
    # todo: filter/enrich/track/intercept the bot/request/data via Spells
    
    bot
  end
 
  # def befriend!(bot) do
  #   # todo: filter/enrich/track/intercept the bot/request/data via Spells
  #   # todo: ilm is all async baby, so we need to spawn the bot, then 
  #   # receive on it's `.unique` from ILM.TowerServer.capture... sleep... wakeup and 
  #   # attempt to respond.
  #   bot |> ILM.Nubspace.upload!  
  # end
  # 
  # @doc """  
  # Add a global Cupcake route to this Castle for Bots to take.
  # allow / deny / xray
  # """
  # defmacro allow(cupcake, contents) do
  #   quote do
  #     bender = fn bot, nub ->
  #       case is_function unquote(contents) do
  #         true -> unquote(contents).(bot, nub)
  #         false -> unquote(contents)
  #       end
  #     end
  #     
  #     Bot.cmd(unquote(cupcake), bender)
  #   end
  # end
  # defmacro deny(cupcake, contents) do
  # defmacro xray(cupcake, contents) do
  
end