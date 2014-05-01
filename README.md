# Internet Land of Magic

ILvMx is an `internet load virtual module exchange` or functionally minded cloud app server and function-level exchange.

The server is written in Elixir-lang but we use `Vagrant` which of course means ILvMx is cloud or self-hostable. Current support for native Elixir and HTTP APIs are in the works, with Elm-lang and other support coming soon.

## Features

- Storage + Code - global hashtag-based namespace of storage + code
- Reactive - completely async event, time, and frame-based execution
- Fun(ctional) - function-level partitioning
- Fast - low overhead `Bots` and default static object graphs
- Open Source - server/apps/dsl are completely open source

## Setup

1. Install VirtualBox (virtualbox.org)
2. Install Vagrant (vagrantup.com)
3. Clone repo `git clone git://github.com/lolnub/ilvmx.git`
4. Edit: `deps/con_cache/mix.exs` to change the :exactor dep to pull from github.

```
# ilvmx/deps/con_cache/mix.exs change `defp deps do` to:

defp deps do
  [{:exactor, github: "sasa1977/exactor"}]
end
```

5. Back to vagrant and our ilvmx server should boot, compile, and test.

```
local$ vagrant ssh
guest$ cd /ilvmx && mix compile && mix test
```

## Playing with the *best* Web 4 theme park and story attraction ever.

- Players (users)
- Castles (servers)
- Wizards (agents)
- Bots (requests)
- Nubs + Nubspace (hashtag based namespace of code + data)
- Nubcakes (a DSL to write apps)

The basic event flow is: apps take requests from protocols like HTTP, SMS, SMTP (from clients, servers, and/or other frameworks) and adapt them into abstract work requests which are then submitted into the core app for processing, distribution, and eventually, the outcome or response stages.

MVC frameworks are a good fit for noun and object oriented-based environments but functional stacks and reactive data flow-based setups with their transform style of development may also be a natural fit for many other tasks.

We hope to define and implement one such pattern of future development.

## Example

Only the core of the API is working but it is enough to get/set/cap/sig/exe against our Nubspace (or hashtag namespace of data + code) into your self-hosted local Castle's Nubspace.

We will soon begin hosting a stream of Galaxy-wide Events from the ilvmx.org server that others will be welcome to consume and append to that stream and that will be our "p2p" network. If other ILvMx servers pop up and start talking to each other, we will form a real network and start adding the p2p.
 
```
# See `Setup` above.. then `vagrant ssh && cd /ilvmx`

vagrant $ iex -S mix
```

## GET/SET/EXE to interact with our hashtag data+code store.

With this example we use the basic request mechanism or `Bot` to interact with our local `Castle` and its `Nubspace`.

```

# Here we add something (the text "todo") to the castle Nubspace "#chat". Now
# anyone on the ILvMx network that had an up-to-date copy of the Galaxy 
# Nubspace would be able to get/set/exe/sort/filter/render this Nub.

iex> Bot.set "#chat", "todo"
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "b4a9b1aa-f63f-416b-b7de-d8c06b86d856", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil, nubcakes: ["todo"]]

# Here we read Nub back out and look in the `nubcakes` field to see
# what the Nubspace holds, at which point the client would interact and
# develop the Nub.

iex> Bot.get "#chat"
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "b4a9b1aa-f63f-416b-b7de-d8c06b86d856", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil, nubcakes: [“todo"]]
 
# In this example, we are going to store a function that others may globally
# execute with arguments. One of the next few project steps is to finish the
# Nubcake DSL so that entire apps may be stored in Nubcakes, and not just
# simple funs.

iex> Bot.set "#chat", fn word -> "lol @ your chat #{ word }" end
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "7192cc1b-6bb4-4f5e-90bb-f1a6ca709f3a", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil,
 nubcakes: ["todo", #Function<6.80484245/1 in :erl_eval.expr/5>]]

# In this example, we will show our executed results. Doge will be builtin
# at some point in the future, so let's get people used to seeing the 
# idea now. You can also see that there were no problems with the request.
# Other notes/erros/exceptions are also presented.

iex> Bot.exe "#chat", "hi"
Bot[nubspace: "#chat", nubcake: "hi",
 results: ["todo",
  Effect[source: nil,
   content: [nubcake: #Function<6.80484245/1 in :erl_eval.expr/5>,
    result: "lol @ your chat hi"]]], problems: [],
 accounts: [cash: [], karma: [dogecoin: "DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG"]],
 unique: "f0b7d860-6d81-49cc-8d8d-ca6e0ef20b18"]
 
```

## CAP(TURE)/SIG(NAL) for reactive updates.

Example of `capping` a nubspace to receive reactive `signal` updates.

```

# Capture a nubspace to be alerted when events happen.

iex(1)> Bot.cap "#chat", fn e -> IO.inspect e end
Event[content: "#chat", source: #PID<0.261.0>]

# Looks like the #chat nubspace is about to change...

iex(2)> Bot.set "#chat", "other"                  
Event[content: Nub[galaxy: :ilvmx, castle: "#lolnub", unique: "acf85c20-b980-44a1-a429-7460205ec642", domain: "#chat",
  system: nil, module: nil, member: nil, method: nil, nubcakes: ["todo", "todo"]],
 source: "acf85c20-b980-44a1-a429-7460205ec642"]
 
Nub[galaxy: :ilvmx, castle: "#lolnub",
 unique: "acf85c20-b980-44a1-a429-7460205ec642", domain: "#chat", system: nil,
 module: nil, member: nil, method: nil, nubcakes: ["todo", #Function<6.80484245/1 in :erl_eval.expr/5>, "other"]]
iex(5)>

```

## [PROPOSAL] Adapt |> Transform |> Emit

Description of a reactive and functional development style for cloud apps.

ATE stands for Adapt |> Transform |> Emit

ATE is an attempt to document a reactive functional development style where data is always pushed forward and each stage or module is only has a single concern that it alone handles. 

Do your job here, push forward – never look back.

1. Adapt: protocol-specific adapters create abstract work requests 
2. Transform: core app executes actor models and updates data
3. Emit: generate objects and events to the outside world

Each stage of the request life cycle is highly concurrent, distributed, and isolated from the outside world.

## Adapt

Take a request, abstract it from the protocol – for example given "GET /users/search/lol" the request becomes "#users #search lol" during :adapt, and any and all request data the adapter (ie. Web+HTTP) passes along is forwarded to the :transform servers. A UUID is returned and the adapter may then optionally cap to be signaled of events for that UUID, otherwise the request is free from any and all other interaction by the requesting agent.

## Transform

The transform servers take the request, dispatch, and execute the request, moving forward through a pipe of functional callbacks, passing the entire request and all effects, any errors, any transactions fees, or earnings, and pushes everything to the :emit pipeline. The transform servers should generally be considered a black box with no direct contact to adapters or emitters.

## Emit

The Emitters now have the complete request, all events, all side effects (i.e. "emit a file to this path", but not necessarily the file contents itself) all errors, every bit of data about the request since it entered the framework is now present in your current state. Emitters just send the request forward to the various protocols you support. So if an :adapter had capped a nub, it would immediately take the :emit results. Another :emitter could log the effects to a DB in the background. Another could make GitHub commits, or msg a channel, and of course if the original adapter all capped the request, the events are obviously pushed forward to it and all other Elixir-lang Plug pipelines, queues, etc. that you've likely already got deployed.

Finally, an Event is :emitted to the entire `:ilvmx` network with any public network-wide data attached that the request should be committed to the network record.

## Support

ILvMx: http://ilvmx.org/

## #lolnub

- http://lolnub.com/
- heh@lolnub.com
- doge: DBV8M8KT3FzGS5dwbUKdvLXJiNzPjwdtpG
