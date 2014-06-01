@doc """
Customize this Castle here. ILM takes place in `Castle` servers in the 
Great Kingdom of Nub. Castles are top-level ILM nodes and the `Galaxy` is 
simply the ILVMX exchange.

Castle, Wizard, and Player are not ILM.namespaced because they are a part 
of the core API, i.e. you could take a vanilla ILM server and edit one 
line in the Castle source or update it dynamically and it would switch 
networks.
"""

Bot.set "#console", Bot.prop "img/patches.png"