local reason = {
  ['Unknown'] = 'Bilinmiyor',
  ['Quit'] = 'kendi isteğiyle',
  ['Kicked'] = 'Atıldı',
  ['Banned'] = 'Uzaklaştırıldı',
  ['Bad Connection'] = 'Kötü İnternet',
  ['Timed out'] = 'İnternet Kesintisi',

}


function quitPlayer(type)
    for i,v in ipairs(getElementsByType('player')) do
        local x,y,z = getElementPosition(source)
        local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local seconds = time.second
    
        local monthday = time.monthday
        local month = time.month
        local year = time.year
        if getDistance(source, v) <= 25 then
        if exports.eu_integration:isPlayerTrialAdmin(v) then
   			triggerClientEvent(v,'quitlog:addPlayer',v,getPlayerName(source),getElementData(source,'account:username'),reason[type],math.ceil(getDistance(source, v)),getZoneName(x,y,z),string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds))
        else
            triggerClientEvent(v,'quitlog:addPlayer',v,getPlayerName(source),'',reason[type],math.ceil(getDistance(source, v)),getZoneName(x,y,z),string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds))
        end
    end
end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )






function getDistance(element, other)
	local x, y, z = getElementPosition(element)
	if isElement(element) and isElement(other) then
		return getDistanceBetweenPoints3D(x, y, z, getElementPosition(other))
	end
end

