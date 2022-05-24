
local sosyalRpTimer = {}
local playerChatTimer = {}
sosyalRolAlani = createColSphere(1940.78515625 ,-1760.19140625, 13.3828125, 25)

function sosyalRpAlaniGiris(thePlayer, matchingDimension)
   if getElementType(thePlayer) == "player" then 
      outputChatBox("[!]#FFFFFF SOSYAL RP Alanına giriş yaptın. Her 1 dakikada / 200$ Kazanacaksın!", thePlayer, 0,255,0,true)
      if getPlayerIdleTime(thePlayer) > 30000 and chatAfk == true then
      outputChatBox("[!]#FFFFFF Bir süredir AFK'sın. Dakika başına 200 TL almaya devam etmeyeceksin.", thePlayer, 255,0,0,true)
   end
      sosyalRpTimer[thePlayer] = setTimer(function() 
        givePlayerMoney(thePlayer, para)
    end, sure, 0)
   end   
end
addEventHandler("onColShapeHit", sosyalRolAlani, sosyalRpAlaniGiris)


function sosyalRpAlaniCikis(thePlayer, matchingDimension)
   if getElementType(thePlayer) == "player" then 
      outputChatBox("[!]#FFFFFF SOSYAL RP Alanından çıkış yaptın.", thePlayer, 255,0,0,true)
      killTimer(sosyalRpTimer[thePlayer])
      sosyalroltimer[thePlayer] = false
   end
end
addEventHandler("onColShapeLeave", sosyalRolAlani, sosyalRpAlaniCikis)
