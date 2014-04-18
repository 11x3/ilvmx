# ILvMx @ project lolnub

Prealpha. Functionally minded cloud app server and eventually exchange. Based on Reactive Functional Programming running on the industrial strength Elixir-lang platform.

## The Best Web 4 theme park and story attraction ever. 

- Castles (servers), 
- Wizards (castle guards)
- Bots (agents/requests), 
- Nubs (p2p global hashtag-based storage namespace),
- Cupcakes (a DSL to write apps)
- Players (users)

ILM/ILvMx or Cupcake apps are `Cloud Apps` in that they run in the cloud *and* service many protocols which really makes calling them "web apps" not feelerino.

Cloud apps take protocol-facing requests (from clients, servers, and/or frameworks) and adapt them into abstract work requests which are then submitted into the core app for processing, distribution, and eventually, the outcome or response.

MVC frameworks are a good fit for noun and object oriented-based environments but functional stacks and data flow event-based kits with their transform style of development may also be a natural fit for many other tasks.

Powered by the EEB stack, we hope to define and implement one such pattern of future development.

Welcome to Internet Land of Magic (Internet Load virtual Module exchange).

## Contact

Join me, code, help the Kickstarter? (l2code?)

ILvMx
http://ilvmx.org/

a lolnub project
http://lolnub.com/
heh@lolnub.com

doge:DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG

## Summary

- Fun - nailed it
- Fun(ctional) - function-level clusters
- Reactive - events and updates, push forward, time and frame-based exe
- Storage + Code - globally routable hashtag graph of storage + code
- Dynamic -100% bootstrap and dynamically program your app from the first function up
- Open - code with Cupcake, Elm, Elixir/Mix, Rails/JS and/or dynamically Fast - static caching object graph
- Powerful - Elixir/Erlang on the server + Elm-lang (or anything else!) on the front. 
- Potential - it won’t take long for more Plugs, Adapters, Emitters, and more Cupcakes to be written in native Elixir and expand the galaxy.

## Example

Only the core of the API is working as of today. But it is enough to get, set, and exe "Nubs" or: global address + data + function into your self-hosted local Castle's Nubspace.

For now we will just publicly host a stream of Events from the server and
others will be welcome to consume the Nubspace event stream and that will be
our "p2p" network. It shouldn't take long to get a few ILM servers actually
talking to each other and forming a real network.
 
SO in this example we use the basic request mechanism or `Bot`. 
```
$ git clone http://github.com/lolnub/ilvmx && cd ilvmx && iex -S mix

# Here we add something (the text "todo") to the global Nubspace "#chat". Now
# anyone on the ILvMx network that had an up-to-date copy of the Galaxy 
# Nubspace would eventually be able to see/sort/filter/exe/download this Nub.
iex> Bot.set "#chat", "todo"
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "b4a9b1aa-f63f-416b-b7de-d8c06b86d856", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil, cupcakes: ["todo"]]

# Read the value back out, and look in the `cupcakes` field because Cupcakes
# are actually the storage mechanism. Galactic Nubspace holds Cupcakes and
# Castles that Bots operate on.
iex> Bot.get "#chat"
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "b4a9b1aa-f63f-416b-b7de-d8c06b86d856", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil, cupcakes: [“todo"]]
 
# In this example, we are going to store a function that others may globally
# execute with arguments. One of the next few project steps is to finish the
# Cupcake DSL so that entire apps may be stored in Cupcakes, and not just
# simple funs.

iex> Bot.set "#chat", fn word -> "lol @ your chat #{ word }" end
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "7192cc1b-6bb4-4f5e-90bb-f1a6ca709f3a", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil,
 cupcakes: ["todo", #Function<6.80484245/1 in :erl_eval.expr/5>]]

# In this example, we have our executed results. Doge will be builtin at some
# point in the future, so let's get people used to seeing the idea now. You
# can also see that there were no problems with the request. Others, any
# exceptions or manually created errors are also presented.
iex> Bot.exe "#chat", "hi"
Bot[nubspace: "#chat", cupcake: "hi",
 results: ["todo",
  Effect[source: nil,
   content: [cupcake: #Function<6.80484245/1 in :erl_eval.expr/5>,
    result: "lol @ your chat hi"]]], problems: [],
 accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
 unique: "f0b7d860-6d81-49cc-8d8d-ca6e0ef20b18"]
```

## ATE or Adapt / Transform / Emit [PROPOSAL]

Description of a reactive and functional development style for cloud apps.

ATE stands for Adapt |> Transform |> Emit

ATE is an attempt to document what many are already doing or starting to do, and other development styles have done for years. ATE is entirely functional we always push state forward, and each modules concerns are theirs alone to compile. Do your job here then push forward. Never look back.

1. Adapt: protocol-specific adapters create abstract work requests 
2. Transform: core app executes actor models and updates data
3. Emit: generate objects and events to the outside world

Thanks to our EEB foundations (Elixir/Erlang/BEAM), each stage of the request life cycle is highly concurrent, distributed, and isolated from the outside world. Following that idea is that there are three primary job states a cloud request may be in: adaptation, transformation, and side-effect emission.


## Adapt

So you take a request, abstract it from the protocol, for example given "GET /users/search/lol" it becomes "#users #search lol" during :adapt, and any and all request data the adapter (ie. HTTP to Cupcake) passes along is forwarded to the :transform servers. A UUID is returned and the adapter may then optionally, subscribe to events and :emits for that UUID, otherwise the request is free from any other interaction by the requesting agent.

## Transform

The transform servers take the request, dispatch, and execute the request, moving forward through a pipe of functional callbacks, passing the entire request and all effects, any errors, any transactions fees, or earnings, and pushes everything to the :emit pipeline. The transform servers should generally be considered a black box with no direct contact to adapters or emitters.

## Emit

The Emitters now have the complete request, all events, all side effects (i.e. "emit a file to this path", but not necessarily the file contents itself) all errors, every bit of data about the request since it entered the framework is now present in your current state. Emitters just send the request forward to the various protocols you support. So if an :adapter had subscribe via a (~) capture signal, it would immediately take the :emit results. Another :emitter could log the effects to a DB in the background. Another could make GitHub commits, or msg a channel, and of course if the original adapter subscribed to Events about the request, the events are obviously pushed forward to it, and/or then out to the Elixir-lang Plug pipeline, or another queue system you've already got deployed.

Finally, an Event is :emitted to the entire lolnub network with any public network-wide data attached that the request should be committed to the network record.

## Requests

Lets think about the modern request life cycle with an outlook for action over endpoint. Instead of:

> Request -> Controller -> Model -> View

We might question the major steps must a request must take from the asking, to the unit of work, to the result:

> Request -> Adapt request -> Transform and dispatch -> Emit events/results

The outside world potentially includes our protocol adapters too. The adapt phase is the first stage of our app where we take a protocol-level request (HTTP, SMTP, IRC, TwitterBot, etc) and create an abstract or generic term-based request, called a work request. Using the default WWW/HTTP adapter as an example, the adapter itself may be an entire EEB or external sub project and in this case we import WWW-related stuff from the Cowboy project (could easily be from an external app on Phoenix, Dynamo, Rails, Twisted, MQ, etc).

Having a complete web app inside/outside our adapter makes all of our favorite features of whichever environment we choose (public/js, controllers, models, routes, search, legacy, etc) available, except instead of generating our specific results inside the web controller's actions and model methods, we only use the other framework to submit work requests into the inner transform core and listen for their event results.

> note: Every successful request returns a UUID that our adapter may ignore or subscribe for events and updates on.

In essence, other existing frameworks and apps may be used entirely inside and outside the adapt and other of Ilvmx.

> tl;dr #adapt - transform web/twitter/irc requests into abstract work requests