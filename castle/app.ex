# Customize this Castle here.
Bot.set "#events #count", fn player ->
  Amnesia.transaction do
    Db.EventDb.keys! |> Stream.each |> Enum.take 100
  end
end