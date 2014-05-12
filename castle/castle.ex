# Customize this Castle here.

Bot.api "#events #count", fn player ->
  Amnesia.transaction do
    Db.Events.keys! |> Stream.each |> Enum.take 100
  end
end
