--[[
* ***********************************************************************************************************************
* Copyright (c) 2018 RelaX Roleplay - All Rights Reserved                                                               *
* Written by Orhan Kalkan, <kalkan32orhan32@gmail.com>,  1.05.2019                                                      *
* ***********************************************************************************************************************
]]

mysql = exports.mrp_mysql

function setUlke(thePlayer, commandName, targetPlayer, ulke)
	if (exports.mrp_integration:isPlayerLeadAdmin(thePlayer)) then
	if (not tonumber(ulke)) then
		outputChatBox("[!] #ffffffBirşey yazmadınız. /ulkedegistir <oyuncu id> <ulkesi>", thePlayer, 255, 0, 0, true)
	else
		if tonumber(ulke) <= 47 and tonumber(ulke) > -1 then
		local targetPlayer, targetPlayerName = exports.mrp_global:findPlayerByPartialNick(thePlayer, targetPlayer)
		if targetPlayer then
			local dbid = getElementData(targetPlayer, "account:character:id")

			outputChatBox("[!] #ffffff"..targetPlayerName.." isimli oyuncuya başarıyla ülkesini ["..ulke.."] yaptınız", thePlayer, 0, 255, 0, true)
			outputChatBox("[!] #ffffff"..getPlayerName(thePlayer).." isimli yetkili ülkenizi ["..ulke.."] yaptı.", targetPlayer, 0, 255, 0, true)
			setElementData(targetPlayer, "ulke", tonumber(ulke))
			dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
		end
			else
				outputChatBox("[!]#ffffff 0 veya 47 arasında değer giriniz.", thePlayer, 255, 0, 0, true)
			end
	end
	else
		outputChatBox("[!]#ffffffBu işlemi yapabilmek için admin olmalısın.", thePlayer, 255, 0, 0, true)
	end
end
addCommandHandler("ulkedegistir",setUlke)

---------------------------ÜLKE PANELİ---------------------------
function amerika(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 1
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("amerika",true)
addEventHandler("amerika",root,amerika)

function almanya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 2
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("almanya",true)
addEventHandler("almanya",root,almanya)

function rusya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 3
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("rusya",true)
addEventHandler("rusya",root,rusya)

function avusturalya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 4
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("avusturalya",true)
addEventHandler("avusturalya",root,avusturalya)

function arjantin(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 5
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("arjantin",true)
addEventHandler("arjantin",root,arjantin)

function belcika(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 6
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("belcika",true)
addEventHandler("belcika",root,belcika)

function bulgaristan(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 7
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("bulgaristan",true)
addEventHandler("bulgaristan",root,bulgaristan)

function cin(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 8
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("cin",true)
addEventHandler("cin",root,cin)

function fransa(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 9
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("fransa",true)
addEventHandler("fransa",root,fransa)

function brezilya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 10
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("brezilya",true)
addEventHandler("brezilya",root,brezilya)

function ingiltere(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 11
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("ingiltere",true)
addEventHandler("ingiltere",root,ingiltere)

function irlanda(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 12
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("irlanda",true)
addEventHandler("irlanda",root,irlanda)

function iskocya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 13
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("iskocya",true)
addEventHandler("iskocya",root,iskocya)

function israil(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 14
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("israil",true)
addEventHandler("israil",root,israil)

function isvec(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 15
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("isvec",true)
addEventHandler("isvec",root,isvec)

function isvicre(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 16
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("isvicre",true)
addEventHandler("isvicre",root,isvicre)

function italya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 17
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("italya",true)
addEventHandler("italya",root,italya)

function jamaika(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 18
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("jamaika",true)
addEventHandler("jamaika",root,jamaika)

function japonya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 19
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("japonya",true)
addEventHandler("japonya",root,japonya)

function kanada(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 20
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("kanada",true)
addEventHandler("kanada",root,kanada)

function kolombiya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 21
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("kolombiya",true)
addEventHandler("kolombiya",root,kolombiya)

function kuba(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 22
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("küba",true)
addEventHandler("küba",root,kuba)

function litvanya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 23
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("litvanya",true)
addEventHandler("litvanya",root,litvanya)

function macaristan(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 24
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("macaristan",true)
addEventHandler("macaristan",root,macaristan)

function makedonya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 25
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("makedonya",true)
addEventHandler("makedonya",root,makedonya)

function meksika(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 26
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("meksika",true)
addEventHandler("meksika",root,meksika)

function nijerya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 27
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("nijerya",true)
addEventHandler("nijerya",root,nijerya)

function norvec(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 28
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("norvec",true)
addEventHandler("norvec",root,norvec)

function peru(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 29
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("peru",true)
addEventHandler("peru",root,peru)

function portekiz(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 30
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("portekiz",true)
addEventHandler("portekiz",root,portekiz)

function romanya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 31
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("romanya",true)
addEventHandler("romanya",root,romanya)

function sirbistan(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 32
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("sirbistan",true)
addEventHandler("sirbistan",root,sirbistan)

function slovakya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 33
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("slovakya",true)
addEventHandler("slovakya",root,slovakya)

function ukrayna(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 34
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("ukrayna",true)
addEventHandler("ukrayna",root,ukrayna)

function yunanistan(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 35
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("yunanistan",true)
addEventHandler("yunanistan",root,yunanistan)

function danimarka(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 36
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("danimarka",true)
addEventHandler("danimarka",root,danimarka)

function yeni_zellanda(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 37
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("yeni_zellanda",true)
addEventHandler("yeni_zellanda",root,yeni_zellanda)

function polonya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 38
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("polonya",true)
addEventHandler("polonya",root,polonya)

function guney_kore(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 39
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("guney_kore",true)
addEventHandler("guney_kore",root,guney_kore)

function hollanda(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 40
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("hollanda",true)
addEventHandler("hollanda",root,hollanda)

function arnavutluk(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 41
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("arnavutluk",true)
addEventHandler("arnavutluk",root,arnavutluk)

function ispanya(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 42
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("ispanya",true)
addEventHandler("ispanya",root,ispanya)

function vietnam(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 43
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("vietnam",true)
addEventHandler("vietnam",root,vietnam)

function misir(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 44
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("mısır",true)
addEventHandler("mısır",root,misir)

function guney_afrika(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 46
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("güney_afrika",true)
addEventHandler("güney_afrika",root,guney_afrika)

function panama(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 47
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("panama",true)
addEventHandler("panama",root,panama)

function yok(thePlayer)
	local dbid = getElementData(thePlayer, "dbid")
	ulke = 0
	setElementData(thePlayer, "ulke", tonumber(ulke))
	dbExec(mysql:getConnection(),"UPDATE `characters` SET `ulke`="..ulke.." WHERE `id`='"..getElementData(thePlayer, "dbid").."'")
end
addEvent("yok",true)
addEventHandler("yok",root,yok)