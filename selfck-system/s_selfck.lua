mysql = exports.mrp_mysql

MTAoutputChatBox = outputChatBox
function outputChatBox( text, visibleTo, r, g, b, colorCoded )
	if string.len(text) > 128 then -- MTA Chatbox size limit
		MTAoutputChatBox( string.sub(text, 1, 127), visibleTo, r, g, b, colorCoded  )
		outputChatBox( string.sub(text, 128), visibleTo, r, g, b, colorCoded  )
	else
		MTAoutputChatBox( text, visibleTo, r, g, b, colorCoded  )
	end
end


function sendCKRequest(target, text)
	showCursor(target, false)
	outputChatBox("Karakter olumu isteginiz olusturuldu, aktif yetkililer ilgilenecektir!", target, 0, 255, 0)
	outputChatBox("Vazgecmek icin /cancelck.", target, 255, 255, 0)
	local playerID = getElementData(target, "playerid")
	local charID = getElementData(target, "dbid")
	for key, value in ipairs(exports.mrp_global:getAdmins()) do
		local adminduty = getElementData(value, "duty_admin")
		if adminduty == 1 then
			outputChatBox("[Karakter Ölümü] " .. getPlayerName( target ):gsub("_", " ") .. " (" .. playerID .. ") isimli kişi karakter ölümü isteği yolladı, sebebi: '" .. text .. "'.", value, 255, 0, 0)
			outputChatBox("[Karakter Ölümü] Kabul etmek için /cka Reddetmek için /ckd.", value, 255, 255, 255)
		end
		triggerClientEvent( value, "addOneToCKCount", value )
	end
	setElementData(target, "ckreason", text)
	setElementData(target, "ckstatus", "requested")
	setElementData(target, "ckchar", charID)
end
addEvent( "sendCKRequest", true )
addEventHandler( "sendCKRequest", getRootElement(), sendCKRequest )

function approveCK(thePlayer, commandName, targetPlayer
	if exports.mrp_integration:isPlayerTrialAdmin(thePlayer) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.mrp_global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local piss = getElementData(targetPlayer, "ckstatus")
			local reason = getElementData(targetPlayer, "ckreason")
			local logged = getElementData(targetPlayer, "loggedin")
			local charID = getElementData(targetPlayer, "ckchar")
			local actualCharID = getElementData(targetPlayer, "dbid")
			if piss=="requested" then
				if (logged==0) then
					outputChatBox("That player is not logged in, automatically cancelling their request.", thePlayer, 255, 0, 0)
					setElementData(targetPlayer, "ckstatus", 0)
					setElementData(targetPlayer, "ckreason", 0)
					triggerClientEvent( value, "subtractOneFromCKCount", value )
				else
					if (actualCharID == charID) then
						setElementData(targetPlayer, "ckstatus", 0)
						setElementData(targetPlayer, "ckreason", 0)
						info = table.concat({reason}, " ")
						local query = dbExec(mysql:getConnection(), "UPDATE characters SET cked='1', ck_info='" .. (tostring(info)) .. "', `death_date`=NOW() WHERE id = " .. (getElementData(targetPlayer, "dbid")))--francisco
						local x, y, z = getElementPosition(targetPlayer)
						local skin = getPedSkin(targetPlayer)
						local rotation = getPedRotation(targetPlayer)
						local look = getElementData(targetPlayer, "look")
						local desc = look[5]
						call( getResourceFromName( "realism" ), "addCharacterKillBody", x, y, z, rotation, skin, getElementData(targetPlayer, "dbid"), targetPlayerName, getElementInterior(targetPlayer), getElementDimension(targetPlayer), getElementData(targetPlayer, "age"), getElementData(targetPlayer, "race"), getElementData(targetPlayer, "weight"), getElementData(targetPlayer, "height"), desc, info, getElementData(targetPlayer, "gender"))
						local id = getElementData(targetPlayer, "account:id")
						showCursor(targetPlayer, false)
							for key, value in ipairs(exports.mrp_global:getAdmins()) do
								local adminduty = getElementData(value, "duty_admin")
								if adminduty == 1 then
									outputChatBox("[Karakter Ölümü] " .. getPlayerName(targetPlayer):gsub("_", " ") .. "'s Karakter ölümü isteğiniz kabul edildi! " .. getPlayerName(thePlayer):gsub("_", " ") .. ".", value, 255, 0, 0)
								end
								triggerClientEvent( value, "subtractOneFromCKCount", value )
							end
						exports.mrp_logs:dbLog(thePlayer, 4, targetPlayer, "Self-CK with reason: "..(tostring(info)))
						triggerClientEvent("showCkWindow", targetPlayer)
						--triggerEvent("updateCharacters", targetPlayer)
						--triggerClientEvent(targetPlayer, "accounts:logout", targetPlayer)
					else
						outputChatBox("Karakteriniz yaşamıyor, yeni karakter açın veya karakter değiştirin.", thePlayer, 255, 0, 0)
						setElementData(targetPlayer, "ckstatus", 0)
						setElementData(targetPlayer, "ckreason", 0)
						setElementData(targetPlayer, "ckchar", 0)
						for key, value in ipairs(exports.mrp_global:getAdmins()) do
							triggerClientEvent( value, "subtractOneFromCKCount", value )
						end
					end
				end
			else
				outputChatBox("This player did not request to be CK'd.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("cka", approveCK)

function declineCK(thePlayer, commandName, targetPlayer)
	if exports.mrp_integration:isPlayerTrialAdmin(thePlayer) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id]", thePlayer, 255, 194, 14)
		else
		local targetPlayer, targetPlayerName = exports.mrp_global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local piss = getElementData(targetPlayer, "ckstatus")
			local adminTitle = exports.mrp_global:getPlayerAdminTitle(thePlayer)
			local charID = getElementData(targetPlayer, "ckchar")
			local actualCharID = getElementData(targetPlayer, "dbid")
			if piss=="requested" then
				if (charID == actualCharID) then
					setElementData(targetPlayer, "ckstatus", 0)
					setElementData(targetPlayer, "ckreason", 0)
					for key, value in ipairs(exports.mrp_global:getAdmins()) do
						local adminduty = getElementData(value, "duty_admin")
						if adminduty == 1 then
							outputChatBox("[SELF-CK] " .. getPlayerName(thePlayer):gsub("_", " ") .. " has denied " .. getPlayerName(targetPlayer):gsub("_", " ") .. "'s Self-CK request.", value, 255, 0, 0)
						end
						triggerClientEvent( value, "subtractOneFromCKCount", value )
					end
					outputChatBox("Your CK request was denied by " .. adminTitle .. " " .. getPlayerName(thePlayer):gsub("_", " ") .. ".", targetPlayer, 255, 0, 0)
				else
					outputChatBox("This player forgot to close their CK request before changing character. Closing CK request now.", thePlayer, 255, 0, 0)
					setElementData(targetPlayer, "ckstatus", 0)
					setElementData(targetPlayer, "ckreason", 0)
					setElementData(targetPlayer, "ckchar", 0)
					for key, value in ipairs(exports.mrp_global:getAdmins()) do
						triggerClientEvent( value, "subtractOneFromCKCount", value )
					end
				end
			else
				outputChatBox(getPlayerName(targetPlayer):gsub("_", " ") .. " does not have a CK request open.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("ckd", declineCK)

function cancelCkRequest(thePlayer)
	local piss = getElementData(thePlayer, "ckstatus")
		if piss=="requested" then
			setElementData(thePlayer, "ckstatus", 0)
			setElementData(thePlayer, "ckreason", 0)
			setElementData(thePlayer, "ckchar", 0)
			outputChatBox("You have successfully cancelled your CK request.", thePlayer, 0, 255, 0)
			for key, value in ipairs(exports.mrp_global:getAdmins()) do
				local adminduty = getElementData(value, "duty_admin")
				if adminduty == 1 then
					outputChatBox("[SELF-CK] " .. getPlayerName(thePlayer):gsub("_", " ") .. " has cancelled their CK request.", value, 255, 0, 0)
				end
				triggerClientEvent( value, "subtractOneFromCKCount", value )
			end
		else
			outputChatBox("You don't currently have a CK request pending.", thePlayer, 255, 0, 0)
		end
end
addCommandHandler("cancelck", cancelCkRequest)

function clearCKRequest(player)
	setElementData(player, "ckstatus", 0)
	setElementData(player, "ckreason", 0)
	setElementData(player, "ckchar", 0)
end

addCommandHandler("cban",
	function(player, cmd, id, ...)
		if exports.mrp_integration:isPlayerTrialAdmin(player) then
			if not (id) or not (...) then
				outputChatBox("SYNTAX: /" .. cmd .. " [id] [Sebep]", player, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.mrp_global:findPlayerByPartialNick(player, id)
				local reason = table.concat({...}, " ")
				if targetPlayer then
					local time = getRealTime()
					local hours = time.hour
					local minutes = time.minute
					local seconds = time.second
					local charactername = getPlayerName(targetPlayer)
					dbExec(mysql:getConnection(), "UPDATE characters SET cked = ? WHERE id = ?", 1, getElementData(targetPlayer, "dbid"))
					outputChatBox("(( "..charactername:gsub("_", " ").." adlı karakter sunucudan yasaklandı. Sebep: "..reason.." - "..hours..":"..minutes..":"..seconds.." ))", root, 255, 0, 0)
					redirectPlayer(targetPlayer,"",0)
					for key, value in ipairs(exports.global:getAdmins()) do
						local adminduty = getElementData(value, "duty_admin")
						if adminduty == 1 then
							outputChatBox("[CBAN] " .. getPlayerName(player):gsub("_", " ") .. " adlı yetkili "..charactername.." adlı karakteri yasakladı.", value, 255, 0, 0)
						end
					end
				end
			end
		end
	end
)

addCommandHandler("ocban",
	function(player, cmd, id, ...)
		if exports.integration:isPlayerTrialAdmin(player) then
			if not (id) or not (...) then
				outputChatBox("SYNTAX: /" .. cmd .. " [karakter_adı] [Sebep]", player, 255, 194, 14)
			else
			
				local reason = table.concat({...}, " ")
				charactername = id
				local time = getRealTime()
				local hours = time.hour
				local minutes = time.minute
				local seconds = time.second
	
				dbExec(mysql:getConnection(), "UPDATE characters SET cked = ? WHERE id = ?", 1, charactername)
				outputChatBox("(( [OFFLINE] : "..charactername:gsub("_", " ").." adlı karakter sunucudan yasaklandı. Sebep: "..reason.." - "..hours..":"..minutes..":"..seconds.." ))", root, 255, 0, 0)
				
				for key, value in ipairs(exports.global:getAdmins()) do
					local adminduty = getElementData(value, "duty_admin")
					if adminduty == 1 then
						outputChatBox("[OCBAN] " .. getPlayerName(player):gsub("_", " ") .. " adlı yetkili "..charactername.." adlı karakteri yasakladı.", value, 255, 0, 0)
					end
				end
				
			end
		end
	end
)

addCommandHandler("uncban",
	function(player, cmd, id)
		if exports.mrp_integration:isPlayerTrialAdmin(player) then
			if not (id) then
				outputChatBox("SYNTAX: /" .. cmd .. " [karakter_adı] [Sebep]", player, 255, 194, 14)
			else
				local charactername = id
				dbExec(mysql:getConnection(), "UPDATE characters SET cked = ? WHERE charactername = ?", 0, id)

				for key, value in ipairs(exports.mrp_global:getAdmins()) do
					local adminduty = getElementData(value, "duty_admin")
					if adminduty == 1 then
						outputChatBox("[CBAN] " .. getPlayerName(player):gsub("_", " ") .. " adlı yetkili "..id.." adlı karakterin yasağını açtı.", value, 255, 0, 0)
					end
				end
			end
		end
	end
)
