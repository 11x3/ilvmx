```
# PROPOSAL: Nubcake - Endgame: Markdown for cloud apps.
#
# ILM apps will offer native Elm-lang support on the front end. And we can 
# also stuff anything else inside `/public/` so bases covered.
#
# Elixir + ILM + Elm should be pretty compelling kit. And Elm looks great for 
# nextgen front end stuff, but as it stands, there's no way it's easy enough
# for end users to learn. 
#
# Nubcake hopes that like Erlang |> Elixir we could be Elm |> Nubcake ;)

# We then have a visual but nearly plain text language. Something
# easily editable and compilable to both Elixir and Elm native terms. Thanks 
# to their functional designs, they are relatively close.

# Nubcake's big top idea is to define an entire cloud app, in an easy enough 
# way to type and code inside a <textarea> or be sent via SMS or through any 
# number of services. You should be able to develop an entire cloud app in 
# an ASCII and humane-level language in less than a minute. Assume other roles 
# are in place (accounts, funds, network, etc) and the goal is to be able to 
# dev an internet wide ILM app on a phone, deploy with a single TXT message or 
# request and it'll do the right thing and your cash/karma will be accounted
# for correctly. :D

# Think: 
# http://twitter.com/
# http://www.serfdom.io/
# http://www.youtube.com/watch?v=H3UES2cMEz4
# http://dogecoin.com

# A great feature of being dead simple to dev+deploy, is the natural
# ability to edit that same code. Because on the Remix Web (lolnub.com) we
# want anyone in the world with a few minutes of time, and a simple ability
# to be able to *fix* things, to contribute to humanity.
#
# We have billions of people grinding on apps already, so let's give them all
# something productive to grind on, and let them earn coin doing it?

# Think:
# All the silly time wasting crap you've ever seen that millions of us do
# https://www.mturk.com/mturk/welcome
# http://github.com
# http://dogecoin.com

# Nubcake is based on ILM which features Nubs that live in a Nubspace which 
# is a simple hashtag based address + 1 x bucket of data. The address part
# has six degrees of built-in separation, "#1".."#6" but Nubs are self 
# referential which means the global p2p "Nubspace" maps to something of a 
# 6 x starting nodes in our graph/map.

# Clients of course are freely open to provide the experience or visualize the
# network however you'd like – ILM will just be servers that all agree on how 
# many and what type of things live at the Nub with the hash tag 
# "#ilm #lolnub #app" or whatever the final syntax is.

# Nubcake v0.0 [PROPOSAL]

# Define a cloud app that lives in the "#me #jam" Nub, and expects one
# arg, which is the current user or @player. An ILvMx server would then
# statically load this app in source at app launch, which also gives you
# full access to program in Elixir+Mix native, or it could be sent as
# plain text over one of the many planned protocol adapters to an ILM server
# and then be added to the Nubspace in real time. It's how we choose
# to build and model our trust system.

# plain text are arguments
@exe "#player", @player

# hash are exes with args
@exe "#search vacations"

# bot-local @variables (temporary nubs) and |> pipes move 
@exe "#search vacations", @vacas

# Get the current Player.age property, run a Nubcake command @greater 18?
@exe "#player!age", "#greater 18"

# ILM here is an app, please execute it in the local #me Nubspace

@app "#me #jam", @player
# ping a nub that contains a before filter nub to verify the player. If
# this nub sends a :break signal inside the app, this the Bot which is
# runs this nub would be terminated, and the errors returned to the client.
@exe, "#ilm #lolnub #players #validate", player
# capture the players nub signal in real time (ie. push data about @player)

@cap
| "#ilm #signals #players", player
@end

# emit a nub on the network that would contribute a stream of the players
# latest happenings, of course anything else on the network could also capture
# or contribute to the signal.

@sig
| "#ilm #signals #players", player
| "#ilm #signals #players #filter #latest", player
@end

@mix player
| [:elixir, "native elixir wanted"]
@end

# a 500x500 suggested centered grid.
@elm
| @set :title, "Welcome to lolnub, #{ player }"       
| @pip "#apps #chat nubspace"           # @ picture in place, or unquote
| @pip "#apps #kb"
| @pip "#http #youtube @pipe #search", "a7x"
| @pip "#apps #footer"
@end


@out "#ilm #filters #after #exitpoll #player", player