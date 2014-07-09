# An example ILvMx app written in cakedown.
@nub lolnub

@set about

# Internet Land of #virtual Magic and #excitement.

ILvMx is a functionally minded cloud app server, or something close to an internet load virtual module exchange. Written with Elixir-lang and `Vagrant` so of course ILvMx is easily cloud or self-hostable. The working-level API currently supports native Elixir, and HTTP APIs, with Elm-lang and other support coming.

# # do stuff when "lolnub/ping" is signaled
# @cap ping
# @sig player/pong

@set todo
- add item creation
- add cake execution

@set ilvmx/players

- Player.signal! .set #lolnub .item
- player start to a publish a nub
	- add apps (programs) from nubspace (ie. a chat app)
	- turn the nub brand red when connected to other nubs
	- turn the brand blue for nubs you trust
  
```
/api/start 
- Player.start! :uuid

/api/player/:uuid/set/(binary/object/program)
```

@set ilvmx
- add @pip support for inline markdown preprocess

@set lolnub.com
- add master/slave droplets
 
@set lolnubapp
- add the hud list view back to the nub ux
- add lolnub meta button to exe/upload functions
- add network wide uuid/registration to doc hud
- add lolnub remix sidebar for web (img, text, link) items 
- add event log

```
|-------------------------------------------------------------
| exe) fix/mac # slashes = exact, spaces = search
| exe) @me/whatever # custom signals
|-------------------------------------------------------------
|  +  | -> 	| nub/web/ilm(sig/remix)																
|-----|-------------------------------------------------------
| pro | -> 	| %{:item => http://support.apple.com/mac/pro }
|-----|-------------------------------------------------------
|			| review: #love, #ok, #hate, |#custom|								
|			| source: Bot/Signal/Player|
|-------------------------------------------------------------
```