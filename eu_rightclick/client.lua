roboto = guiCreateFont( ":eu_fonts/files/RobotoB.ttf", 13 )
robotoL = guiCreateFont( ":eu_fonts/files/Roboto.ttf", 10 )
rcmenu = false
local rcWidth = 0
local rcHeight = 0

function destroy()
	return true
end


function leftClickAnywhere(button, state, absX, absY, wx, wy, wz, element)
	if(button == "left" and state == "down") then
		if isElement(rcmenu) then

		end
	end
end
addEventHandler("onClientClick", getRootElement(), leftClickAnywhere, true)
addEvent("serverTriggerLeftClick", true)
addEventHandler("serverTriggerLeftClick", localPlayer, leftClickAnywhere)

function create(title)
	return true
end

function addRow(title,header,nohover)
	return true
end

function addrow(title,header,nohover)
	return true
end