addCommandHandler('setfaction', function(thePlayer, commandName, partialNick, factionID)
	if exports.eu_integration:isPlayerSeniorAdmin(thePlayer) then
		local factionID = tonumber(factionID)
		if not (partialNick) or not (factionID) then
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [Target ID] [faction ID]',195,184,116,true)
		else
			local targetPlayer, targetPlayerNick = exports.eu_global:findPlayerByPartialNick(thePlayer, partialNick)
			if targetPlayer then
				local theTeam = exports.eu_pool:getElement("team", factionID)
				if not theTeam and factionID ~= -1 then
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Hatalı faction ID!',195,184,116,true)
					return
				end
				if dbExec(connection:getConnection(),"UPDATE characters SET faction_leader = 0, faction_id = " .. factionID .. ", faction_rank = 1, faction_phone = NULL, duty = 0 WHERE id=" .. targetPlayer:getData('dbid')) then
					if factionID > 0 then
						targetPlayer.team = theTeam
						targetPlayer:setData('faction', factionID, true)
						targetPlayer:setData('factionrank', 1, true)
						targetPlayer:setData('factionphone', nil, true)
						targetPlayer:setData('factionleader', 0, true)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Başarıyla '..targetPlayer.name..' isimli oyuncuyu '..factionID..' ID birliğe atadınız!',195,184,116,true)
						targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli yetkili sizi '..factionID..' ID birliğe atadı!',195,184,116,true)
						exports.eu_logs:dbLog(thePlayer, 4, { targetPlayer, thePlayer }, 'SET TO FACTION')
					else
						local citizenTeam = Team.getFromName('Citizen')
						targetPlayer.team = citizenTeam
						targetPlayer:setData('faction', -1, true)
						targetPlayer:setData('factionrank', 1, true)
						targetPlayer:setData('factionphone', nil, true)
						targetPlayer:setData('factionleader', 0, true)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Başarıyla '..targetPlayer.name..' isimli oyuncuyu birliğinden çıkardınız!',195,184,116,true)
						targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli yetkili sizi birliğinizden çıkardı!',195,184,116,true)
						exports.eu_logs:dbLog(thePlayer, 4, { targetPlayer, thePlayer }, 'REMOVE FROM FACTION')
					end
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
				end
			end
		end
	end
end)

addCommandHandler('setfactionleader', function(thePlayer, commandName, partialNick, factionID)
	if exports.eu_integration:isPlayerSeniorAdmin(thePlayer) then
		local factionID = tonumber(factionID)
		if not (partialNick) or not (factionID) then
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [Target ID] [faction ID]',195,184,116,true)
		else
			local targetPlayer, targetPlayerNick = exports.eu_global:findPlayerByPartialNick(thePlayer, partialNick)
			if targetPlayer then
				local theTeam = exports.eu_pool:getElement("team", factionID)
				if not theTeam and factionID ~= -1 then
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Hatalı faction ID!',195,184,116,true)
					return
				end
				if dbExec(connection:getConnection(),"UPDATE characters SET faction_leader = 1, faction_id = " .. factionID .. ", faction_rank = 1, faction_phone = NULL, duty = 0 WHERE id=" .. targetPlayer:getData('dbid')) then
					if factionID > 0 then
						targetPlayer.team = theTeam
						targetPlayer:setData('faction', factionID, true)
						targetPlayer:setData('factionrank', 1, true)
						targetPlayer:setData('factionphone', nil, true)
						targetPlayer:setData('factionleader', 1, true)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Başarıyla '..targetPlayer.name..' isimli oyuncuyu '..factionID..' ID birliğe lider atadınız!',195,184,116,true)
						targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli yetkili sizi '..factionID..' ID birliğe lider atadı!',195,184,116,true)
						exports.eu_logs:dbLog(thePlayer, 4, { targetPlayer, thePlayer }, 'SET TO FACTION')
					else
						local citizenTeam = Team.getFromName('Citizen')
						targetPlayer.team = citizenTeam
						targetPlayer:setData('faction', -1, true)
						targetPlayer:setData('factionrank', 1, true)
						targetPlayer:setData('factionphone', nil, true)
						targetPlayer:setData('factionleader', 0, true)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Başarıyla '..targetPlayer.name..' isimli oyuncuyu birliğinden çıkardınız!',195,184,116,true)
						targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli yetkili sizi birliğinizden çıkardı!',195,184,116,true)
						exports.eu_logs:dbLog(thePlayer, 4, { targetPlayer, thePlayer }, 'REMOVE FROM FACTION')
					end
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
				end
			end
		end
	end
end)

addCommandHandler('birlikonayla', function(thePlayer, commandName, factionID)
	if exports.eu_integration:isPlayerDeveloper(thePlayer) then
		if tonumber(factionID) then
			local theTeam = exports.eu_pool:getElement("team", factionID)
			if theTeam then
				if theTeam:getData('approval') == 1 then
					dbExec(connection:getConnection(), "UPDATE factions SET approval='0' WHERE id='" .. factionID .. "'")
					theTeam:setData('approval', tonumber(0))
					for index, value in ipairs(theTeam.players) do
						value:outputChat('Birlik:#D0D0D0 '..thePlayer.name..' isimli yetkili birliğinizin onayını aldı!',195,184,116,true)
					end
				else
					dbExec(connection:getConnection(), "UPDATE factions SET approval='1' WHERE id='" .. factionID .. "'")
					theTeam:setData('approval', tonumber(1))
					for index, value in ipairs(theTeam.players) do
						value:outputChat('Birlik:#D0D0D0 '..thePlayer.name..' isimli yetkili birliğinizi onayladı!',195,184,116,true)
					end
				end
			else
				thePlayer:outputChat('[ClientDev]:#D0D0D0 Hatalı faction ID!',195,184,116,true)
			end
		else
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [Birlik ID]',195,184,116,true)
		end
	end
end)

addCommandHandler('renamefaction', function(thePlayer, commandName, ...)
	if thePlayer:getData('factionleader') == 1 then
		if not (...)  then
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [Yeni İsim]',195,184,116,true)
		else
			if string.len(...) > 16 then
				thePlayer:outputChat('[ClientDev]:#D0D0D0 Birlik adı çok uzun olmamalı!',195,184,116,true)
			return end
			local theTeam = thePlayer.team
			local factionID = thePlayer:getData('faction') or 0
			if theTeam then
				local newName = table.concat({...}, " ")
				if dbExec(connection:getConnection(),"UPDATE factions SET name='" .. (newName) .. "' WHERE id='" .. factionID .. "'") then
					local oldName = theTeam.name
					for index, value in ipairs(theTeam.players) do
						value:outputChat('Birlik:#D0D0D0 '..thePlayer.name..' isimli lider birliğin ismini değiştirdi!',195,184,116,true)
					end
					theTeam.name = newName
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
				end
			end
		end
	end
end)

addCommandHandler('abv', function(thePlayer, commandName)
	if thePlayer:getData('loggedin') == 1 then
		local theVehicle = thePlayer.vehicle
		if theVehicle then
			local owner = theVehicle:getData('owner') or 0
			local playerDB = thePlayer:getData('dbid')
			local playerFact = thePlayer:getData('faction')
			local vehicleDB = theVehicle:getData('dbid')
			local vehicleFact = theVehicle:getData('faction')
			if owner == playerDB then
				if playerFact > 0 then
					if dbExec(connection:getConnection(), "UPDATE vehicles SET faction='" .. (playerFact) .. "' WHERE id='" .. (vehicleDB) .. "'") then
						exports["eu_vehicle"]:reloadVehicle(vehicleDB)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Aracınız bulunduğunuz birliğe eklendi.',195,184,116,true)
					else
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
					end
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Herhangi bir birlikte değilsiniz!',195,184,116,true)
				end
			end
		end
	end
end)

addCommandHandler('abg', function(thePlayer, commandName)
	if thePlayer:getData('loggedin') == 1 then
		local theVehicle = thePlayer.vehicle
		if theVehicle then
			local owner = theVehicle:getData('owner') or 0
			local playerDB = thePlayer:getData('dbid')
			local playerFact = thePlayer:getData('faction')
			local vehicleDB = theVehicle:getData('dbid')
			local vehicleFact = theVehicle:getData('faction')
			if owner == playerDB then
				if vehicleFact > 0 then
					if dbExec(connection:getConnection(), "UPDATE vehicles SET faction='-1' WHERE id='" .. (vehicleDB) .. "'") then
						exports["eu_vehicle"]:reloadVehicle(vehicleDB)
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Aracınız bulunduğu birlikten çıkarttınız.',195,184,116,true)
					else
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
					end
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Aracınız zaten bir birlikte değil!',195,184,116,true)
				end
			end
		end
	end
end)

addCommandHandler('birlikolustur', function(thePlayer, commandName, ...)
	if thePlayer:getData('loggedin') == 1 then
		if (...) then
			local playerFact = thePlayer:getData('faction')
			if playerFact <= 0 then
				if string.len(...) > 16 then
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Birlik adı çok uzun olmamalı!',195,184,116,true)
				return end
				if exports.eu_global:takeMoney(thePlayer, 10000) then
					local name = table.concat({...}, " ")
					local id = SmallestID()
					local theTeam = Team.create(tostring(name))
					if theTeam then
						if dbExec(connection:getConnection(), "INSERT INTO factions SET id='"..(id).."', name='"..(name).."', bankbalance='0', type='0'") then
							dbExec(connection:getConnection(),"UPDATE characters SET faction_leader = 1, faction_id = "..id..", faction_rank = 1, faction_phone = NULL, duty = 0 WHERE id = " .. thePlayer:getData('dbid'))
							dbExec(connection:getConnection(), "UPDATE factions SET rank_1='Rank #1', rank_2='Rank #2', rank_3='Rank #3', rank_4='Rank #4', rank_5='Rank #5', rank_6='Rank #6', rank_7='Rank #7', rank_8='Rank #8', rank_9='Rank #9', rank_10='Rank #10', rank_11='Rank #11', rank_12='Rank #12', rank_13='Rank #13', rank_14='Rank #14', rank_15='Rank #15', rank_16='Rank #16', rank_17='Rank #17', rank_18='Rank #18', rank_19='Rank #19', rank_20='Rank #20',  motd='Birliğe hoş geldiniz.', note = '' WHERE id='" .. id .. "'")
							
							dbQuery(
								function(qh)
									local res, rows, err = dbPoll(qh, 0)
									if rows > 0 then
										for index, row in ipairs(res) do
											local id = tonumber(row.id)
											local name = row.name
											local money = tonumber(row.bankbalance)
											local factionType = tonumber(row.type)

											exports.eu_pool:allocateElement(theTeam, id)
											theTeam:setData('type', factionType, true)
											theTeam:setData('money', money, true)
											theTeam:setData('id', id, true)

											local factionRanks = {}
											local factionWages = {}
											for i = 1, 20 do
												factionRanks[i] = row['rank_'..i]
												factionWages[i] = tonumber(row['wage_'..i])
											end

											theTeam:setData('ranks', factionRanks, true)
											theTeam:setData('wages', factionWages, true)
											theTeam:setData('motd', row.motd, false)
											theTeam:setData('note', row.note == nil and "" or row.note, true)
											theTeam:setData('fnote', row.fnote == nil and "" or row.fnote, true)
											theTeam:setData('phone', row.phone ~= nil and row.phone or nil, false)
											theTeam:setData('max_interiors', tonumber(row.max_interiors), false, true)
											theTeam:setData('level', tonumber(row.level))
											theTeam:setData('approval', tonumber(row.approval))
										end
									end
								end,
							connection:getConnection(), "SELECT * FROM factions WHERE id = ?", id)
							
							thePlayer.team = theTeam
							thePlayer:setData('faction', id, true)
							thePlayer:setData('factionrank', 1, true)
							thePlayer:setData('factionphone', nil, true)
							thePlayer:setData('factionleader', 1, true)
							thePlayer:outputChat('[ClientDev]:#D0D0D0 10.000₺ ödeyerek birlik oluşturdunuz!(F3)',195,184,116,true)
						else
							thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
						end
					else
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Birlik adı kullanılıyor!',195,184,116,true)
					end
				else
					thePlayer:outputChat('[ClientDev]:#D0D0D0 Birlik oluşturmak için 10.000₺ paranızın olması gerek!',195,184,116,true)
				end
			else
				thePlayer:outputChat('[ClientDev]:#D0D0D0 Birlik oluşturmak için var olan birliğinizden çıkmalısınız!',195,184,116,true)
			end
		else
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [Birlik Adı]',195,184,116,true)
		end
	end
end)

addCommandHandler('birlik', function(thePlayer, commandName, func, partialNick)
	if thePlayer:getData('loggedin') == 1 then
		if func then
			if func == 'davet' then
				if thePlayer:getData('faction') >= 1 then
					if thePlayer:getData('faction') == 1 or thePlayer:getData('faction') == 2 or thePlayer:getData('faction') == 78 then else
						if thePlayer:getData('factionleader') == 1 then
							if not partialNick then
								thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' davet [Target ID]',195,184,116,true)
							else
								local targetPlayer, targetPlayerNick = exports.eu_global:findPlayerByPartialNick(thePlayer, partialNick)
								if targetPlayer then
									if targetPlayer == thePlayer then
										thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
									else
										local x, y, z = thePlayer.position.x, thePlayer.position.y, thePlayer.position.z
										local tx, ty, tz = targetPlayer.position.x, targetPlayer.position.y, targetPlayer.position.z
										local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)
										if (distance<=10) then
											if targetPlayer:getData('faction') >= 1 then
												thePlayer:outputChat('[ClientDev]:#D0D0D0 '..targetPlayer.name..' isimli kişi zaten bir birlikte!',195,184,116,true)
											else
												thePlayer:outputChat('[ClientDev]:#D0D0D0 '..targetPlayer.name..' isimli kişiyi birliğinize davet ettiniz.',195,184,116,true)
												targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli kişi sizi birliğine davet ediyor.',195,184,116,true)
												targetPlayer:outputChat('[ClientDev]:#D0D0D0 /birlik',195,184,116,true)
												targetPlayer:setData('faction.invite', true)
												targetPlayer:setData('faction.inviter', thePlayer)
											end
										else
											thePlayer:outputChat('[ClientDev]:#D0D0D0 '..targetPlayer.name..' isimli kişiden çok uzaktasınız!',195,184,116,true)
										end
									end
								end
							end
						end
					end
				end
			elseif func == 'kabul' then
				if thePlayer:getData('faction.invite') then
					local inviter = thePlayer:getData('faction.inviter') or nil
					if inviter then
						thePlayer:outputChat('[ClientDev]:#D0D0D0 '..inviter.name..' isimli kişinin davetini kabul ettiniz.',195,184,116,true)
						inviter:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli kişi davetinizi kabul etti.',195,184,116,true)
						local factionID = inviter:getData('faction')
						local theTeam = exports.eu_pool:getElement("team", factionID)
						if theTeam then
							dbExec(connection:getConnection(),"UPDATE characters SET faction_leader = 0, faction_id = " .. factionID .. ", faction_rank = 1, faction_phone = NULL, duty = 0 WHERE id=" .. thePlayer:getData('dbid'))
							thePlayer.team = theTeam
							thePlayer:setData('faction', factionID, true)
							thePlayer:setData('factionrank', 1, true)
							thePlayer:setData('factionphone', nil, true)
							thePlayer:setData('factionleader', 0, true)
							exports.eu_logs:dbLog(inviter, 4, { thePlayer, inviter }, 'INVITE TO FACTION')
						else
							thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
						end
						thePlayer:removeData('faction.invite')
						thePlayer:removeData('faction.inviter')
					else
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
					end
				end
			elseif func == 'red' then
				if thePlayer:getData('faction.invite') then
					local inviter = thePlayer:getData('faction.inviter') or nil
					if inviter then
						thePlayer:outputChat('[ClientDev]:#D0D0D0 '..inviter.name..' isimli kişinin davetini geri çevirdiniz.',195,184,116,true)
						inviter:outputChat('[ClientDev]:#D0D0D0 '..thePlayer.name..' isimli kişi davetinizi geri çevirdi.',195,184,116,true)
						thePlayer:removeData('faction.invite')
						thePlayer:removeData('faction.inviter')
					else
						thePlayer:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
					end
				end
			else
				thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [davet/kabul/red]',195,184,116,true)
			end
		else
			thePlayer:outputChat('[ClientDev]:#D0D0D0 /'..commandName..' [davet/kabul/red]',195,184,116,true)
		end
	end
end)