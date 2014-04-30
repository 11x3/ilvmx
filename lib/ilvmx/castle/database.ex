use Amnesia

defdatabase Db do
     
  deftable EventDb, [{:id, autoincrement}, :content, :source, :unique] do
    @type t :: EventDb[id: integer, content: String.t, source: String.t, unique: String.t]    
  end
  
end