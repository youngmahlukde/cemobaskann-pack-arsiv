function getTeamFromfactionID(factionID)
	if not tonumber(factionID) then
		return false
	else 
		factionID = tonumber(factionID)
	end
	return exports.eu_pool:getElement("team", factionID)
end

function getfactionName(factionID)
	local theTeam = getTeamFromfactionID(factionID)
	if theTeam then
		local name = getTeamName(theTeam)
		if name then
			name = tostring(name)
			return name
		end
	end
	return false
end

function getfactionType(factionID)
	local theTeam = getTeamFromfactionID(factionID)
	if theTeam then
		local ftype = tonumber(getElementData(theTeam, "type"))
		if ftype then
			return ftype
		end
	end
	return false
end

function getfactionFromName(factionName)
	for k,v in ipairs(exports.eu_pool:getPoolElementsByType("team")) do
		if string.lower(getTeamName(v)) == string.lower(factionName) then
			return v
		end
	end
	return false
end

function getfactionIDFromName(factionName)
	local theTeam = getfactionFromName(factionName)
	if theTeam then
		local id = tonumber(getElementData(theTeam, "id"))
		if id then
			return id
		end
	end
	return false
end