# # setup an "app" and variables at this signal/path
# @app lolnub
# | key:     /value
# | nub:     /6/5/4/3/2/1
# | author:   /authors/1
# | item:   binary/object/program
#
# @pip graph
# @pip endpoints
# @pip /obj/img/01372.jpg
#
# @set graph
#
# #---------------------
# |castle|   > |signal|
#         > |signal| > |program: content/params|
# ...
#
# castle |> signal |> program |> cpu |> bot |> effect
#
# - write params disk and do not pass them on until called
# #---------------------
#
# @set endpoints
# | class: row
#
# - /app/ browsers
# - /api/ commands
# - /bin/ binaries
# - /obj/ objects
# - /nub/ folders + items/links
#
# /api/start
# - Player.start! :uuid
# /api/player/:uuid/set/(binary/object/program)
# - Player.signal! .set #lolnub .item
#
# @set tickets
#
# - nubspace travel on signals, signals are active connections
# - player start to a publish a nub
#   - add apps (programs) from nubspace (ie. a chat app)
#   - turn the nub brand red when connected to other nubs
#   - turn the brand blue for nubs you trust
# - add the hud list view back to the nub ux
# - add lolnub meta button to exe/upload functions
# - add network wide uuid/registration to doc hud
# - add lolnub remix sidebar to drag items
# (img, text, link) from web and nub view and then upload them to a new nub space
# - add exe as an overview mode
# - add event log
