#todo: switch to riak

use Amnesia

defdatabase Db do
     
  deftable Events,  [{:id, autoincrement}, :content, :source, :unique] do
    @type t :: Events[id: integer, content: String.t, source: String.t, unique: String.t]    
  end
  
  deftable Sessions, [{:id, autoincrement}, :content, :source, :unique] do
    @type t :: Sessions[id: integer, content: String.t, source: String.t, unique: String.t]    
  end
  
end