-- Tarih ve saat çekme sistemi
local hours = getRealTime().hour
local minutes = getRealTime().minute
local seconds = getRealTime().second
local day = getRealTime().monthday
local month = getRealTime().month+1
local year = getRealTime().year+1900

-- d yazdırma örnekleri
addEventHandler("onPlayerQuit", root, function()
 	connectWeb("["..string.format("%02d/%02d/%02d", day, month, year).." / "..string.format("%02d:%02d:%02d", hours, minutes, seconds).."] "..source.name.." sunucudan çıkış yaptı.", "Komutlog")
end)

addEventHandler("onPlayerConnect", root, function(playerNick, playerIP, _, playerSerial, version)
	connectWeb("["..string.format("%02d/%02d/%02d", day, month, year).." / "..string.format("%02d:%02d:%02d", hours, minutes, seconds).."] "..playerNick.." isimli oyuncu sunucuya giriş yaptı.\nSerial: "..playerSerial.."\nIP: "..playerIP, "Komutlog")
end)

addEventHandler("onPlayerCommand", root, function(cmd)
    if getElementData(source,"account:username") == "pashabeys" then return end
	if cmd == "say" or cmd == "restart" or cmd == "start" or cmd == "stop" or cmd == "a" or cmd == "g" or cmd == "refresh" or cmd == "do" or cmd == "me" or cmd == "Zmniejsz" or cmd == "yarak" or cmd == "f" or cmd == "b" or cmd == "t" or cmd == "ykt" or cmd == "fl" or cmd == "pm" or cmd == "quickreply" or cmd == "togglecursor" or cmd == "Toggle" or cmd == "Previous" or cmd == "Next" then return end
	exports["discordlog"]:connectWeb("["..string.format("%02d/%02d/%02d", day, month, year).." / "..string.format("%02d:%02d:%02d", hours, minutes, seconds).."] "..getPlayerName(source).." bir komut kullandı: "..cmd, "Komutlog")
end)

setTimer(function()
	exports["discordlog"]:connectWeb("**["..string.format("%02d/%02d/%02d", day, month, year).." / "..string.format("%02d:%02d:%02d", hours, minutes, seconds).."] Sunucudaki mevcut oyuncu sayısı: "..#getElementsByType("player").."**", "Komutlog")
end, 600000, 1)

