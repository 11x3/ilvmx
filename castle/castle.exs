# Customize this Castle here.

# Program
# -------
# get "example"
# set "@example args"
# exe "#example args"
# jmp "!example #results"
# pip "#results |> #take 5"

# # Examples

# Bot.set "#events", fn player ->
#   Amnesia.transaction do
#     Db.Events.keys! |> Stream.each |> Enum.take 100
#   end
# end
# 
# Bot.set "#chat", fn nick, chat ->
#   Bot.set "chat", "#{ nick }: #{ chat }"
# end

# # Custom API

Bot.set "#splash", Prop.static("priv/static/index.html")
