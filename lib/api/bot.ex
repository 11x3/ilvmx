defmodule Bot do
  defstruct program: nil,
            effects: [],           
             errors: [],
            storage: nil,
             player: nil,
           accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
             unique: nil

  # Native API

  @doc """
  Execute `nubspace` with `program`. 
  """
  # def exe(program) do
  #   throw IO.inspect program
  # end
  # def exe(program) when is_binary(program) do
  #   bot = %Bot{
  #      program: program,
  #       unique: ILVMX.Castle.Server.uuid,
  #      storage: HashDict.new
  #   } 
  #   bot |> ILVMX.Castle.CPU.Server.execute!
  # end
  # def exe(program) when is_function(program) do
  #   throw IO.inspect program
  # end
  
  
  # Nubspace API
  
  @doc """
  Store `prop` at `nubspace`.
  """
  def set(nubspace, item) do
    ILVMX.Nub.Server.push!(nubspace, item)
  end
  
  @doc """
  Get a `nub` from `nubspace`.
  
  > Program.run "#example!" => {link: "/nub/1/item", meta: "/nub/1/meta"}
  """
  def get!(nubspace) do
  end
  def get(nubspace) do
    ILVMX.Nub.Server.pull!(nubspace)
  end
  
  @doc """
  Capture a `nubspace` and evaluate nubcake when signaled.
  
  Returns `bot`.
  """
  def cap(nubspace, program) do
    ILVMX.Castle.Tower.Server.capture!(nubspace, program)
  end
  
  
  # Prop API
  
  @doc """
  Take objects from The World, oh our dear World.
  # todo: secure the path, yes yes yes
  """
  def prop(nubspace) do
    # todo: secure path
    File.read! Path.join("priv/static", nubspace)
  end
  
  @doc """
  Place objects into The World, oh our dear World.
  """
  def drop(nubspace, item) do
    # set the meta
    #set(nubspace, item)

  end
  
  @doc """
  Read a file from the internet.
  # todo: secure the path, yes yes yes
  # todo: add web REST support
  """
  def web(path) do
    HTTPotion.get(path).body
  end
  
end