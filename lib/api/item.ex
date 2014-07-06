defmodule Item do
  defstruct   kind: nil,
            unique: nil,  # "32453-4544-3434-234324-7879"
            binary: nil,  # ""  => "/obj/32453/4544-3434-234324-7879"
            object: nil   # %{} => "/obj/32453/meta"

  def w do
    %Item{ unique: ILM.Castle.uuid }
  end
  
  @doc """
  Return the API or public (on-disk) path to an item.
  """
  def path(item) do
    "/obj/#{ item.unique }"
  end

end
