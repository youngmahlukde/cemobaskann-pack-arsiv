dxDrawText = dxDrawText
dxDrawRectangle = dxDrawRectangle
triggerServerEvent = triggerServerEvent
getTickCount = getTickCount
getKeyState = getKeyState
tocolor = tocolor
faction = {}
faction.__index = faction
faction.screen = Vector2(guiGetScreenSize())
faction.width, faction.height = 800, 550
faction.sizeX, faction.sizeY = (faction.screen.x-faction.width), (faction.screen.y-faction.height)
faction.roboto = exports.eu_fonts:getFont('Roboto',13)
faction.robotoB = exports.eu_fonts:getFont('RobotoB',11)

function faction:create()
    local instance = {}
    setmetatable(instance, faction)
    if instance:constructor() then
        return instance
    end
    return false
end

function faction:constructor()
    self = faction;
    addEvent('faction.open.panel', true)
    addEventHandler('faction.open.panel', root, self.open)
    addEvent('faction.member.data', true)
    addEventHandler('faction.member.data', root, function(...) self:memberData(...) end)
    addEvent('faction.vehicle.data', true)
    addEventHandler('faction.vehicle.data', root, function(...) self:vehicleData(...) end)
    addEventHandler('onClientCharacter', root, function(...) self:key(...) end)
    bindKey('F3', 'down', function()
        triggerServerEvent('faction.load.data', localPlayer)
    end)
    bindKey("mouse_wheel_down", "down", self.wheelDown)
    bindKey("mouse_wheel_up", "down", self.wheelUp)
end

function faction:memberData(dat)
    self = faction;
    self.members = dat
end

function faction:vehicleData(dat)
    self = faction;
    self.cars = dat
end

function faction:render()
    self = faction;
    local sizeX, sizeY = self.sizeX, self.sizeY
    local width, height = self.width, self.height
    local playerTeam = localPlayer.team
    local playerTeamName = playerTeam.name
    local teamRanks = playerTeam:getData('ranks')
    local teamWages = playerTeam:getData('wages')

    self:roundedRectangle(sizeX/2, sizeY/2+50, width, height+15, tocolor(30,30,30,245))

    if self:isInBox(sizeX/2+760, sizeY/2+60, 25, 25) then
        dxDrawText('X', sizeX/2+770, sizeY/2+60, 25, 25, tocolor(175,175,175,235), 1, self.roboto)
        if getKeyState('mouse1') and self.click+800 <= getTickCount() then
            self.click = getTickCount()
            self.close()
        end
    else
        dxDrawText('X', sizeX/2+770, sizeY/2+60, 25, 25, tocolor(225,225,225,235), 1, self.roboto)
    end

    if not playerTeam or playerTeamName == 'Citizen' then
        exports["eu_object_preview"]:setAlpha(self.preview_skin, 0)
        dxDrawText('buralar boş gözüküyor..', sizeX/2+350, sizeY/2+300, 25, 25, tocolor(175,175,175,235), 0.75, self.roboto)
    else

        if playerTeam:getData('approval') == 1 then
            self.approvalStat = 'Onaylanmış Birlik'
        else
            self.approvalStat = 'Onaylanmamış Birlik'
        end

        dxDrawText('ID '..playerTeam:getData('id')..': '..playerTeamName..' / '..self.approvalStat, sizeX/2+25, sizeY/2+65, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

        if self.selectedPlayer and localPlayer:getData('factionleader') == 1 then
            exports["eu_object_preview"]:setAlpha(self.preview_skin, 0)
            dxDrawText('Üye Yönetimi: '..self.selectedPlayer, sizeX/2+470, sizeY/2+65, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            self:roundedRectangle(sizeX/2+470, sizeY/2+100, width/2-100, height-220, tocolor(25,25,25,235))

            if self:isInBox(sizeX/2+485, sizeY/2+115, 125, 25) then
                self:roundedRectangle(sizeX/2+485, sizeY/2+115, 125, 25, tocolor(7,7,7,235))
                dxDrawText('Lider Yap', sizeX/2+520, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    triggerServerEvent('faction.leader', localPlayer, self.selectedPlayer)
                end
            else
                self:roundedRectangle(sizeX/2+485, sizeY/2+115, 125, 25, tocolor(15,15,15,235))
                dxDrawText('Lider Yap', sizeX/2+520, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            if self:isInBox(sizeX/2+630, sizeY/2+115, 125, 25) then
                self:roundedRectangle(sizeX/2+630, sizeY/2+115, 125, 25, tocolor(7,7,7,235))
                dxDrawText('Uzaklaştır', sizeX/2+662, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    triggerServerEvent('faction.kick', localPlayer, self.selectedPlayer)
                end
            else
                self:roundedRectangle(sizeX/2+630, sizeY/2+115, 125, 25, tocolor(15,15,15,235))
                dxDrawText('Uzaklaştır', sizeX/2+662, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            dxDrawText('Rütbe', sizeX/2+485, sizeY/2+195, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            dxDrawText('Maaş', sizeX/2+675, sizeY/2+195, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

            self.ranksY = 0
            self.ranksCount = 0
            for i = 1, 20 do
                self.rankSS = i
                if i > self.rankScroll and self.ranksCount < self.maxScroll then
                    if self:isInBox(sizeX/2+475, sizeY/2+215+self.ranksY, width/2-100-10, 15) then
                        self:roundedRectangle(sizeX/2+475, sizeY/2+215+self.ranksY, width/2-100-10, 15, tocolor(7,7,7,235))
                        if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                            self.click = getTickCount()
                            triggerServerEvent('faction.set.rank', localPlayer, self.selectedPlayer, i)
                        end
                    else
                        self:roundedRectangle(sizeX/2+475, sizeY/2+215+self.ranksY, width/2-100-10, 15, tocolor(15,15,15,235))
                    end
                    dxDrawText(teamRanks[i], sizeX/2+485, sizeY/2+215+self.ranksY, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    dxDrawText(''..teamWages[i]..'₺', sizeX/2+675, sizeY/2+215+self.ranksY, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    self.ranksCount = self.ranksCount + 1
                    self.ranksY = self.ranksY + 20
                end
            end

        elseif not self.selectedPlayer and not self.editRanks then
            dxDrawText('Karakterinizin Birlik Bilgileri', sizeX/2+470, sizeY/2+65, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            self:roundedRectangle(sizeX/2+470, sizeY/2+100, 285, height/2.5, tocolor(25,25,25,235))
            exports["eu_object_preview"]:setAlpha(self.preview_skin, 255)
            if localPlayer:getData('factionleader') == 1 then
                self.stat = 'Lider'
            else
                self.stat = 'Üye'
            end
            local factRank = localPlayer:getData('factionrank')
            dxDrawText(localPlayer.name, sizeX/2+555, sizeY/2+200, 25, 25, tocolor(175,175,175,235), 0.85, self.robotoB)
            dxDrawText('Birlik Yetkiniz: '..self.stat, sizeX/2+555, sizeY/2+230, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            dxDrawText('Rütbeniz: '..teamRanks[factRank], sizeX/2+555, sizeY/2+245, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            dxDrawText('Maaşınız: '..teamWages[factRank]..'₺', sizeX/2+555, sizeY/2+260, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        elseif self.editRanks and not self.selectedPlayer then
            exports["eu_object_preview"]:setAlpha(self.preview_skin, 0)
            dxDrawText('Birlik Rütbe/Maaş Düzeni', sizeX/2+470, sizeY/2+65, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            self:roundedRectangle(sizeX/2+470, sizeY/2+100, width/2-100, height-220, tocolor(25,25,25,235))

            if self:isInBox(sizeX/2+485, sizeY/2+115, 125, 25) then
                self:roundedRectangle(sizeX/2+485, sizeY/2+115, 125, 25, tocolor(7,7,7,235))
                dxDrawText('Vazgeç', sizeX/2+525, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    self.selectedPlayer = nil
                    self.editRanks = false
                end
            else
                self:roundedRectangle(sizeX/2+485, sizeY/2+115, 125, 25, tocolor(15,15,15,235))
                dxDrawText('Vazgeç', sizeX/2+525, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            if self:isInBox(sizeX/2+630, sizeY/2+115, 125, 25) then
                self:roundedRectangle(sizeX/2+630, sizeY/2+115, 125, 25, tocolor(7,7,7,235))
                dxDrawText('Kaydet', sizeX/2+673, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    triggerServerEvent('faction.save.ranks', localPlayer, self.scR, self.scW, self.rankText, self.wageText)
                end
            else
                self:roundedRectangle(sizeX/2+630, sizeY/2+115, 125, 25, tocolor(15,15,15,235))
                dxDrawText('Kaydet', sizeX/2+673, sizeY/2+120, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            dxDrawText('Rütbe Adı', sizeX/2+485, sizeY/2+175, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            dxDrawText('Maaş', sizeX/2+675, sizeY/2+175, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

            self.ranksY2 = 0
            self.ranksCount2 = 0
            for index, value in ipairs(teamRanks) do
                self.rankSS2 = teamRanks
                if index > self.rankScroll2 and self.ranksCount2 < 9 then
                    if self:isInBox(sizeX/2+475, sizeY/2+200+self.ranksY2, width/2-225-10, 20) then
                        self:roundedRectangle(sizeX/2+475, sizeY/2+200+self.ranksY2, width/2-225-10, 20, tocolor(7,7,7,235))
                        if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                            self.click = getTickCount()
                            self.selectedText = 'Fact.rank'
                            self.rankText = ''
                            self.scW = nil
                            self.scR = index
                        end
                    else
                        self:roundedRectangle(sizeX/2+475, sizeY/2+200+self.ranksY2, width/2-225-10, 20, tocolor(15,15,15,235))
                    end
                    if self:isInBox(sizeX/2+670, sizeY/2+200+self.ranksY2, width/2-300-10, 20) then
                        self:roundedRectangle(sizeX/2+670, sizeY/2+200+self.ranksY2, width/2-300-10, 20, tocolor(7,7,7,235))
                        if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                            if self.scR == index then
                                self.click = getTickCount()
                                self.selectedText = 'Fact.wage'
                                self.wageText = ''
                                self.scW = index
                            end
                        end
                    else
                        self:roundedRectangle(sizeX/2+670, sizeY/2+200+self.ranksY2, width/2-300-10, 20, tocolor(15,15,15,235))
                    end
                    if index == self.scR then
                        dxDrawText(self.rankText, sizeX/2+485, sizeY/2+202+self.ranksY2, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    else
                        dxDrawText(value, sizeX/2+485, sizeY/2+202+self.ranksY2, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    end
                    if index == self.scW then
                        dxDrawText(''..self.wageText..'₺', sizeX/2+675, sizeY/2+202+self.ranksY2, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    else
                        dxDrawText(''..teamWages[index]..'₺', sizeX/2+675, sizeY/2+202+self.ranksY2, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                    end
                    self.ranksY2 = self.ranksY2 + 25
                    self.ranksCount2 = self.ranksCount2 + 1
                end
            end
        end

        if localPlayer:getData('factionleader') == 1 and not self.leaveCheck then
            if self:isInBox(sizeX/2+440, sizeY/2+515, 150, 25) then
                self:roundedRectangle(sizeX/2+440, sizeY/2+515, 150, 25, tocolor(7,7,7,235))
                dxDrawText('Araçları Yenile', sizeX/2+475, sizeY/2+520, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    triggerServerEvent('faction.respawn.allVehicle', localPlayer, localPlayer:getData('faction'))
                end
            else
                self:roundedRectangle(sizeX/2+440, sizeY/2+515, 150, 25, tocolor(15,15,15,235))
                dxDrawText('Araçları Yenile', sizeX/2+475, sizeY/2+520, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            if self:isInBox(sizeX/2+440, sizeY/2+550, 150, 25) then
                self:roundedRectangle(sizeX/2+440, sizeY/2+550, 150, 25, tocolor(7,7,7,235))
                dxDrawText('Aracı Yenile', sizeX/2+480, sizeY/2+555, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    if self.selectedVeh then
                        triggerServerEvent('faction.respawn.vehicle', localPlayer, self.selectedVeh)
                    end
                end
            else
                self:roundedRectangle(sizeX/2+440, sizeY/2+550, 150, 25, tocolor(15,15,15,235))
                dxDrawText('Aracı Yenile', sizeX/2+480, sizeY/2+555, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end
            
            if self:isInBox(sizeX/2+440, sizeY/2+480, 150, 25) then
                self:roundedRectangle(sizeX/2+440, sizeY/2+480, 150, 25, tocolor(7,7,7,235))
                dxDrawText('Rütbeler', sizeX/2+490, sizeY/2+485, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    if self.editRanks then
                        self.editRanks = false
                    else
                        self.editRanks = true
                        self.scR = nil
                        self.scW = nil
                    end
                end
            else
                self:roundedRectangle(sizeX/2+440, sizeY/2+480, 150, 25, tocolor(15,15,15,235))
                dxDrawText('Rütbeler', sizeX/2+490, sizeY/2+485, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end
        end

        if self.leaveCheck then
            dxDrawText('Ayrılmak istediğine emin misin?', sizeX/2+590, sizeY/2+535, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

            if self:isInBox(sizeX/2+570, sizeY/2+565, 100, 25) then
                self:roundedRectangle(sizeX/2+570, sizeY/2+565, 100, 25, tocolor(7,7,7,235))
                dxDrawText('Ayrıl', sizeX/2+607, sizeY/2+570, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    triggerServerEvent('faction.leave', localPlayer)
                end
            else
                self:roundedRectangle(sizeX/2+570, sizeY/2+565, 100, 25, tocolor(15,15,15,235))
                dxDrawText('Ayrıl', sizeX/2+607, sizeY/2+570, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end

            if self:isInBox(sizeX/2+690, sizeY/2+565, 100, 25) then
                self:roundedRectangle(sizeX/2+690, sizeY/2+565, 100, 25, tocolor(7,7,7,235))
                dxDrawText('Vazgeç', sizeX/2+720, sizeY/2+570, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    self.leaveCheck = false
                end
            else
                self:roundedRectangle(sizeX/2+690, sizeY/2+565, 100, 25, tocolor(15,15,15,235))
                dxDrawText('Vazgeç', sizeX/2+720, sizeY/2+570, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end
        else
            if self:isInBox(sizeX/2+620, sizeY/2+550, 150, 25) then
                self:roundedRectangle(sizeX/2+620, sizeY/2+550, 150, 25, tocolor(7,7,7,235))
                dxDrawText('Birlikten Ayrıl', sizeX/2+655, sizeY/2+555, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
                if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                    self.click = getTickCount()
                    self.leaveCheck = true
                end
            else
                self:roundedRectangle(sizeX/2+620, sizeY/2+550, 150, 25, tocolor(15,15,15,235))
                dxDrawText('Birlikten Ayrıl', sizeX/2+655, sizeY/2+555, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
            end
        end

        self:roundedRectangle(sizeX/2+25, sizeY/2+100, width/2, height/2.5, tocolor(25,25,25,235))
        dxDrawText('Üye Adı', sizeX/2+55, sizeY/2+100, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        dxDrawText('Rütbe', sizeX/2+235, sizeY/2+100, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        dxDrawText('Yetki', sizeX/2+380, sizeY/2+100, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

        self.playerY = 0
        self.playerCount = 0

        for index, value in ipairs(self.members) do
            if index > self.playerScroll and self.playerCount < self.maxScroll then
                if self:isInBox(sizeX/2+30, sizeY/2+115+self.playerY, width/2-10, 15) then
                    self:roundedRectangle(sizeX/2+30, sizeY/2+115+self.playerY, width/2-10, 15, tocolor(7,7,7,235))
                    if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                        if localPlayer:getData('factionleader') == 1 then
                            self.click = getTickCount()
                            if self.selectedPlayer == value[1] then
                                self.selectedPlayer = nil
                            else
                                self.selectedPlayer = value[1]
                            end
                        end
                    end
                else
                    if value[1] == self.selectedPlayer then
                        self:roundedRectangle(sizeX/2+30, sizeY/2+115+self.playerY, width/2-10, 15, tocolor(7,7,7,235))
                    else
                        self:roundedRectangle(sizeX/2+30, sizeY/2+115+self.playerY, width/2-10, 15, tocolor(15,15,15,235))
                    end
                end
                dxDrawText(value[1], sizeX/2+30, sizeY/2+115+self.playerY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                dxDrawText(teamRanks[value[2]], sizeX/2+200, sizeY/2+115+self.playerY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                if value[3] == 1 then
                    dxDrawText('Lider', sizeX/2+380, sizeY/2+115+self.playerY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                else
                    dxDrawText('Üye', sizeX/2+380, sizeY/2+115+self.playerY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                end
                self.playerCount = self.playerCount + 1
                self.playerY = self.playerY + 20
            end
        end

        self:roundedRectangle(sizeX/2+25, sizeY/2+360, width/2, height/2.5, tocolor(25,25,25,235))
        dxDrawText('Birlik Araçları', sizeX/2+25, sizeY/2+335, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        dxDrawText('ID', sizeX/2+35, sizeY/2+360, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        dxDrawText('Marka', sizeX/2+100, sizeY/2+360, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)
        dxDrawText('Plaka', sizeX/2+300, sizeY/2+360, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

        self.vehicleY = 0
        self.vehicleCount = 0

        for index, value in ipairs(self.cars) do
            if index > self.carScroll and self.vehicleCount < self.maxScroll then
                if self:isInBox(sizeX/2+30, sizeY/2+375+self.vehicleY, width/2-10, 15) then
                    self:roundedRectangle(sizeX/2+30, sizeY/2+375+self.vehicleY, width/2-10, 15, tocolor(7,7,7,235))
                    if getKeyState('mouse1') and self.click+800 <= getTickCount() then
                        if localPlayer:getData('factionleader') == 1 then
                            self.click = getTickCount()
                            if self.selectedVeh == value[1] then
                                self.selectedVeh = nil
                            else
                                self.selectedVeh = value[1]
                            end
                        end
                    end
                else
                    if value[1] == self.selectedVeh then
                        self:roundedRectangle(sizeX/2+30, sizeY/2+375+self.vehicleY, width/2-10, 15, tocolor(7,7,7,235))
                    else
                        self:roundedRectangle(sizeX/2+30, sizeY/2+375+self.vehicleY, width/2-10, 15, tocolor(15,15,15,235))
                    end
                end

                dxDrawText(value[1], sizeX/2+35, sizeY/2+375+self.vehicleY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                dxDrawText(value[2], sizeX/2+100, sizeY/2+375+self.vehicleY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                dxDrawText(value[3], sizeX/2+300, sizeY/2+375+self.vehicleY, 25, 25, tocolor(200,200,200,235), 0.75, self.roboto)
                self.vehicleCount = self.vehicleCount + 1
                self.vehicleY = self.vehicleY + 20
            end
        end

        self.pCount = 0

        for index, value in ipairs(Element.getAllByType('player')) do
            if value:getData('faction') == localPlayer:getData('faction') then
                self.pCount = self.pCount + 1
            end
        end 
        dxDrawText('Aktif '..self.pCount..' Üye', sizeX/2+370, sizeY/2+595, 25, 25, tocolor(175,175,175,235), 0.75, self.robotoB)

        if self:isInBox(sizeX/2+25, sizeY/2+360, width/3, height/2.5) then
            selectedScroll = 'Car.scroll'
        elseif self:isInBox(sizeX/2+25, sizeY/2+100, width/2, height/2.5) then
            selectedScroll = 'Player.scroll'
        elseif self:isInBox(sizeX/2+470, sizeY/2+100, width/2-100, height-220) and self.selectedPlayer then
            selectedScroll = 'Edit.rank.scroll'
        elseif self:isInBox(sizeX/2+470, sizeY/2+100, width/2-100, height-220) and self.editRanks then
            selectedScroll = 'Edit.fact.rank.scroll'
        else
            selectedScroll = ''
        end

    end
end

function faction:open()
    if localPlayer:getData('loggedin') == 1 then
        self = faction;
        if self.active then
            self.close()
        else
            self.active = true
            self.leaveCheck = false
            self.selectedPlayer = nil
            self.selectedVeh = nil
            self.click = 0
            self.maxScroll = 10
            self.carScroll = 0
            self.playerScroll = 0
            self.rankScroll = 0
            self.rankScroll2 = 0
            self.editRanks = false
            self.selectedText = ''
            self.rankText = ''
            self.wageText = ''
            self.scR = nil
            self.scW = nil
            self.previewSkin = createPed(localPlayer.model, 0, 0, 0)
			self.previewSkin:setData('alpha', 255)
			self.previewSkin:setDimension(999)
			self.preview_skin = exports["eu_object_preview"]:createObjectPreview(self.previewSkin, 0, 0, 180, self.sizeX/2+400, self.sizeY/2+80, 450/2, 460/2, false, true)
            exports["eu_object_preview"]:setAlpha(self.preview_skin, 255)
            exports["eu_object_preview"]:setRotation(self.preview_skin,0, 0, 195)
            showCursor(true)
            addEventHandler('onClientRender', root, self.render, true, 'low-10')
        end
    end
end

function faction:close()
    self = faction;
    self.active = false
    showCursor(false)
    self.previewSkin:destroy()
	exports['eu_object_preview']:destroyObjectPreview(self.preview_skin)
    removeEventHandler('onClientRender', getRootElement(), self.render)
end

function faction:key(character)
    self = faction;
    if self.active then
        if self.selectedText == 'Fact.rank' then
            if string.len(self.rankText) > 16 then
                self.rankText = ''
            else
                self.rankText = ''..self.rankText..''..character..''
            end
        elseif self.selectedText == 'Fact.wage' then
            if tonumber(character) then
                if string.len(self.wageText) > 3 then
                    self.wageText = ''
                else
                    self.wageText = ''..self.wageText..''..character..''
                end
            end
        end
    end
end

function faction:wheelUp()
    self = faction;
    if self.active then
        if selectedScroll == 'Car.scroll' then
            if self.carScroll > 0 then
                self.carScroll = self.carScroll - 1
            end
        elseif selectedScroll == 'Player.scroll' then
            if self.playerScroll > 0 then
                self.playerScroll = self.playerScroll - 1
            end
        elseif selectedScroll == 'Edit.rank.scroll' then
            if self.rankScroll > 0 then
                self.rankScroll = self.rankScroll - 1
            end
        elseif selectedScroll == 'Edit.fact.rank.scroll' then
            if self.rankScroll2 > 0 then
                self.rankScroll2 = self.rankScroll2 - 1
            end
        end
    end
end

function faction:wheelDown()
    self = faction;
    if self.active then
        if selectedScroll == 'Car.scroll' then
            if self.carScroll < #self.cars - self.maxScroll then
                self.carScroll = self.carScroll + 1
            end
        elseif selectedScroll == 'Player.scroll' then
            if self.playerScroll < #self.members - self.maxScroll then
                self.playerScroll = self.playerScroll + 1
            end
        elseif selectedScroll == 'Edit.rank.scroll' then
            if self.rankScroll < self.rankSS - self.maxScroll then
                self.rankScroll = self.rankScroll + 1
            end
        elseif selectedScroll == 'Edit.fact.rank.scroll' then
            if self.rankScroll2 < #self.rankSS2 - 9 then
                self.rankScroll2 = self.rankScroll2 + 1
            end
        end
    end
end

function faction:roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end
        if (not bgColor) then
            bgColor = borderColor;
        end
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
    end
end

function faction:isInBox(xS,yS,wS,hS)
    if(isCursorShowing()) then
        local cursorX, cursorY = getCursorPosition()
        sX,sY = guiGetScreenSize()
        cursorX, cursorY = cursorX*sX, cursorY*sY
        if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
            return true
        else
            return false
        end
    end
end

faction:create()