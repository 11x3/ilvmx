require Logger

defmodule Hug do
  
  @moduledoc """
  A promise to get a reply or Item from something at a later date.
  """
  
  # ask player for input, save program, return link to resume program
  # Hug.plz Player.p1, program.step[program]
  
  def plz?(signal, player) do
    #todo: ping the signal_path for resumable programs and pass in the players response
    # %Hug{ask: "hi, want to join?", reply: ["yes!" => "/program/123/step/12/yes", "ignore"]}
  end
  
end