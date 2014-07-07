defmodule Program do
  defstruct  setup: %{},
              code: [],
              data: %{},
            errors: [],
            player: nil,
            unique: nil

  def exe(signal) do
    IO.inspect "@@@ signal: #{ signal }"




    signal
  end

end


