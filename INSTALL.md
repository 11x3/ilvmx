```
local$ git clone git@github.com:lolnub/ilvmx.git
local$ cd ilvmx 
local$ vagrant up
```

Edit: `deps/con_cache/mix.exs` to change the :exactor dep to pull from github.

```
defp deps do
  [{:exactor, github: "sasa1977/exactor"}]
end
```

Back to vagrant and our ilvmx server should boot, compile, and test.

```
local$ vagrant ssh
guest$ cd /ilvmx && mix compile && mix test
```