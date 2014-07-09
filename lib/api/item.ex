defmodule Item do
  defstruct   kind: nil,  # mime/type
            unique: nil,  # "32453-4544-3434-234324-7879"
            object: nil,  # %{} => "/obj/32453/meta"
            binary: nil   # ""  => "/obj/32453/4544-3434-234324-7879"

  def w do
    #todo: create object
    #todo: create binary
        
    %Item{ unique: ILM.Castle.uuid }
  end

  # data/json type
  def object(item) do
    "obj/#{ item.unique }.json"
  end
  
  # binary type
  def binary(item) do
    "bin/#{ item.unique }.#{ item.kind }"
  end
  
end
