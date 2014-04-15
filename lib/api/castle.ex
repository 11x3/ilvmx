defmodule Castle do

  @doc """
  ILM takes place in an unknown time, in an unknown `Castle` server in 
  the great land of Nub. This is not scoped out very well (yet), but Castles 
  are top-level ILM nodes and the `Galaxy` is simply the ILvMx exchange.
  """
  
  @doc """
  ILvMx network exchange.
  """
  def galaxy, do: :ilvmx
  
  @doc """
  Only the mightiest of Nub Doors in the land protect `Castle` "#lolnub".
  """
  def door, do: "#lolnub"

  @doc """
  Send a `Cupcake` carrying `Bot` into the Castle, return an Event back that
  be captured and signaled or ignored.
  # Spawn |> Event[unique: uuid] 
  """
  def arrow!(bot = Bot[]) do
    ILM.Wizard.deflect! bot
  end

  # @doc """
  # Send a Cupcake message into the Castle and wait for the results.
  # Spawn |> Wait |> Bot
  # """
  # def dove!(bot) do
  #   
  # end
  
  # @doc """  
  # Add a global Cupcake route to this Castle for Bots to take.
  # """
  # defmacro let(cupcake, contents) do
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
  
  # allow / deny / xray
end