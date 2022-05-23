exports = exports
tonumber = tonumber
addEvent = addEvent
addEventHandler = addEventHandler
addCommandHandler = addCommandHandler
connection = exports.eu_mysql

SmallestID = function()
	local query = dbQuery(connection:getConnection(), "SELECT MIN(e1.id+1) AS nextID FROM factions AS e1 LEFT JOIN factions AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	local result = dbPoll(query, -1)
	if result then
		local id = tonumber(result[1]["nextID"]) or 1
		return id
	end
	return false
end

addEventHandler('onResourceStart', resourceRoot, function()
	dbQuery(
		function(qh)
			local res, rows, err = dbPoll(qh, 0)
			if rows > 0 then
				for index, row in ipairs(res) do
					local id = tonumber(row.id)
					local name = row.name
					local money = tonumber(row.bankbalance)
					local factionType = tonumber(row.type)
					local theTeam = Team.create(tostring(name))
					if theTeam then
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

						local citteam = Team.create('Citizen', 255, 255, 255)
						exports.eu_pool:allocateElement(citteam, -1)
		
						for index, value in ipairs(Element.getAllByType('player')) do
							if value:getData('loggedin') == 1 then
								value.team = exports.eu_pool:getElement('team', value:getData('faction') or -1) or citteam
							end
						end
					end
				end
			end
		end,
	connection:getConnection(), "SELECT * FROM factions ORDER BY id ASC")
end)

addEvent('faction.respawn.vehicle', true)
addEventHandler('faction.respawn.vehicle', root, function(vehicleID)
	if source and tonumber(vehicleID) then
		local theVehicle = exports.eu_pool:getElement("vehicle", tonumber(vehicleID))
		if theVehicle then
			local playerTeam = source.team
			for index, value in ipairs(playerTeam.players) do
				value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider '..vehicleID..' ID aracı respawnladı.',195,184,116,true)
			end

			theVehicle:respawn()
			theVehicle.interior = theVehicle:getData('interior')
			theVehicle.dimesion = theVehicle:getData('dimension')
			theVehicle.locked = true
		end
	end
end)

addEvent('faction.respawn.allVehicle', true)
addEventHandler('faction.respawn.allVehicle', root, function(factionID)
	if source and tonumber(factionID) then
		local playerTeam = source.team
		for index, value in ipairs(playerTeam.players) do
			value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider tüm araçları respawnladı.',195,184,116,true)
		end
		for index, value in ipairs(Element.getAllByType('vehicle')) do
			if value:getData('faction') == factionID then
				value:respawn()
				value.interior = value:getData('interior')
				value.dimesion = value:getData('dimension')
				value.locked = true
			end
		end
	end
end)

addEvent('faction.leave', true)
addEventHandler('faction.leave', root, function()
	if source then
		local playerTeam = source.team
		for index, value in ipairs(playerTeam.players) do
			value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli üye birlikten ayrıldı.',195,184,116,true)
		end
		source.team = Team.getFromName('Citizen')
		source:setData('faction', -1)
		source:setData('factionleader', 0)
		dbExec(connection:getConnection(), "UPDATE characters SET faction_id='-1', faction_leader='0', faction_rank='1', duty = 0 WHERE charactername='" .. (source.name) .. "'")
	end
end)

addEvent('faction.load.data', true)
addEventHandler('faction.load.data', root, function()
	if source then

		local factionID = source:getData('faction') or -1
		local members = {}
		dbQuery(
			function(qh, source)
				local res, rows, err = dbPoll(qh, 0)
				if rows > 0 then
					for index, value in ipairs(res) do
						local i = #members + 1
						if not members[i] then
							members[i] = {}
						end
						members[i][1] = value.charactername or 'Unknown'
						members[i][2] = value.faction_rank or 'Unknown'
						members[i][3] = value.faction_leader or 'Unknown'
					end
				end
				triggerClientEvent(source, 'faction.member.data', source, members)
			end,
		{source}, connection:getConnection(), "SELECT * FROM characters WHERE faction_ID = ?", factionID)

		local vehicles = {}
		dbQuery(
			function(qh, source)
				local res, rows, err = dbPoll(qh, 0)
				if rows > 0 then
					for index, value in ipairs(res) do
						local i = #vehicles + 1
						if not vehicles[i] then
							vehicles[i] = {}
						end
						vehicles[i][1] = value.id or 'Unknown'
						vehicles[i][2] = 'Unknown'
						vehicles[i][3] = value.plate or 'Unknown'

					end
				end
				triggerClientEvent(source, 'faction.vehicle.data', source, vehicles)
			end,
		{source}, connection:getConnection(), "SELECT * FROM vehicles WHERE faction = ?", factionID)

		triggerClientEvent(source, 'faction.open.panel', source)
	end
end)

addEvent('faction.kick', true)
addEventHandler('faction.kick', root, function(targetName)
	if source and targetName then
		if dbExec(connection:getConnection(), "UPDATE characters SET faction_id='-1', faction_leader='0', faction_rank='1', duty = 0 WHERE charactername='" .. (targetName) .. "'") then
			local targetPlayer = Player(targetName)
			if targetPlayer then
				targetPlayer.team = Team.getFromName('Citizen')
				targetPlayer:setData('faction', -1)
				targetPlayer:setData('factionleader', 0)
				targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..source.name..' isimli lider sizi birlikten uzaklaştırdı!',195,184,116,true)
			end
			local playerTeam = source.team
			for index, value in ipairs(playerTeam.players) do
				value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider '..targetName..' isimli üyeyi birlikten uzaklaştırdı!',195,184,116,true)
			end
		else
			source:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
		end
	end
end)

addEvent('faction.leader', true)
addEventHandler('faction.leader', root, function(targetName)
	if source and targetName then
		if dbExec(connection:getConnection(), "UPDATE characters SET faction_leader='1' WHERE charactername='" .. (targetName) .. "'") then
			local targetPlayer = Player(targetName)
			if targetPlayer then
				targetPlayer:setData('factionleader', 1, true)
				targetPlayer:outputChat('[ClientDev]:#D0D0D0 '..source.name..' isimli lider sizi lider olarak atadı!',195,184,116,true)
			end
			local playerTeam = source.team
			for index, value in ipairs(playerTeam.players) do
				value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider '..targetName..' isimli üyeyi lider olarak atadı!',195,184,116,true)
			end
		else
			source:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
		end
	end
end)

addEvent('faction.set.rank', true)
addEventHandler('faction.set.rank', root, function(targetName, num)
	if source and targetName and num then
		if dbExec(connection:getConnection(), "UPDATE characters SET faction_rank='"..num.."' WHERE charactername='" .. (targetName) .. "'") then
			local targetPlayer = Player(targetName)
			if targetPlayer then
				targetPlayer:setData('factionrank', num, true)
		    end
		    local playerTeam = source.team
			for index, value in ipairs(playerTeam.players) do
				value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider '..targetName..' isimli üyenin rütbesini düzenledi!',195,184,116,true)
			end
		else
			source:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
		end
	end
end)

addEvent('faction.save.ranks', true)
addEventHandler('faction.save.ranks', root, function(scR, scW, rankText, wageText)
	if source and tonumber(scR) and tonumber(scW) then
		local factID = source:getData('faction')
		local playerTeam = source.team
		local playerTeamName = playerTeam.name
		if dbExec(connection:getConnection(), "UPDATE factions SET rank_"..scR.." = '"..rankText.."' WHERE id='" .. (factID) .. "'") then
			if dbExec(connection:getConnection(), "UPDATE factions SET wage_"..scW.." ='"..wageText.."' WHERE id='" .. (factID) .. "'") then
				dbQuery(
					function(qh, source)
						local res, rows, err = dbPoll(qh, 0)
						if rows > 0 then
							for index, row in ipairs(res) do
								local factionRanks = {}
								local factionWages = {}
								for i = 1, 20 do
									factionRanks[i] = row['rank_'..i]
									factionWages[i] = tonumber(row['wage_'..i])
								end
								playerTeam:setData('ranks', factionRanks, true)
								playerTeam:setData('wages', factionWages, true)
							end
							for index, value in ipairs(playerTeam.players) do
								value:outputChat('Birlik:#D0D0D0 '..source.name..' isimli lider birlik rütbe/maaş üzerinde değişiklik yaptı.',195,184,116,true)
							end
						end
					end,
				{source}, connection:getConnection(), "SELECT * FROM factions WHERE id = ?", factID)
			else
				source:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
			end
		else
			source:outputChat('[ClientDev]:#D0D0D0 Bir hata meydana geldi!',195,184,116,true)
		end
	end
end)