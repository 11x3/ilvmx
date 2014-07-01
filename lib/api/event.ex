defmodule Event do
  defstruct  galaxy: nil,
             castle: nil,
            program: nil,
             player: nil,
            effects: [],
             unique: nil
  
  @moduledoc """
  The basic news unit of our ILM kingdom.
  """
  def w(program, player \\ nil) do
    %Event{
       galaxy: ILM.Castle.Server.galaxy,
       castle: ILM.Castle.Server.name,
      program: program,
       player: player,
       unique: ILM.Castle.Server.uuid
    }
  end
end
