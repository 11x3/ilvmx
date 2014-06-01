defmodule Event do
  defstruct  castle: nil,
            program: nil,
             player: nil,
            effects: [],
             unique: nil
  
  @moduledoc """
  The basic news unit of our ILVMX kingdom.
  """
  def w(program, player \\ nil) do
    %Event{
       castle: ILVMX.Castle.Server.name,
      program: program,
       player: player,
       unique: ILVMX.Castle.Server.uuid
    }
  end
end
