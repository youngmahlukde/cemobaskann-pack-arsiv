addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "loadmodule") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "sfakelag") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "fakelag") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "tufansiker") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "tufansiker2") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "mtasiker") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "mtasiker2") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "avradinizisikim") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "sunucubizim") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

addEventHandler("onPlayerCommand",root,
    function(command)
    if (command == "oocbakiyever") then
        cancelEvent()
        outputChatBox("[!]#ffffff Akıllı adamsın, yeteri kadar değil.",source,255,0,0,true)
    end
end)

function fanFunction()
    bindKey (source,"F10","down",
      function(player,key,state)
        outputChatBox (getPlayerName (player) .. "#FFFF00 thinks MTA:SA is so cool.",root,255,255,0,true)
      end
    )
  end
  addEventHandler ("onPlayerLogin",root,fanFunction)