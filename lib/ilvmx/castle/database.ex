use Amnesia

defdatabase Db do
  
  deftable HwEvent, [{:id, autoincrement}, :content] do
    @type t :: HwEvent[id: integer, content: String.t]    
  end

  deftable HwRequest, [{:id, autoincrement}, :id, :query, :topic, :epoch, :created, :complete, :uuid, :meta_id, :contents] do
    @type t :: HwRequest[
      id: integer, 
      query: Boolean.t,
      topic: String.t, # topic = target.action as an mfa-style term #note1
      epoch: String.t,
      created: String.t,
      complete: String.t,
      uuid: String.t, 
      meta_id: integer,
      contents: String.t,
    ]    
  end
  # note1: topic is our core mfa style request routing argument. 
  # request = {:users, :update, 123, payload: {profile: {nick: "lol"}}
  # Basically, we can break the dispatch down to an object-specific level
    
  deftable HwRequestMeta, [{:id, autoincrement}, :uuid, :id, :read, :updated, :destroyed, :agent] do
    @type t :: HwRequestMeta[
      id: integer, 
      read: String.t,
      updated: String.t,
      destroyed: String.t,
      agent: String.t,
    ]    
  end

  deftable HwAppState, [{:id, autoincrement}, :id, :k, :v, :c, :u] do
    @type t :: HwAppState[
      id: integer, 
      k: String.t, 
      v: String.t,
      c: String.t,
      u: String.t
    ]    
  end
  
end