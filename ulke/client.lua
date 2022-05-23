--[[
* ***********************************************************************************************************************
* Copyright (c) 2018 RelaX Roleplay - All Rights Reserved                                                               *
* Written by Orhan Kalkan, <kalkan32orhan32@gmail.com>,  1.05.2019                                                      *
* ***********************************************************************************************************************
]]

GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}   

function ulkePanel()
        local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 232) / 2, (screenH - 306) / 2, 232, 306, "Ülke Seçme Paneli", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        GUIEditor.button[1] = guiCreateButton(10, 271, 213, 25, "Kaydet", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFE4D4D")
        GUIEditor.gridlist[1] = guiCreateGridList(12, 29, 211, 240, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "Ülkeler", 0.9)
        for i = 1, 47 do
            guiGridListAddRow(GUIEditor.gridlist[1])
        end
        guiGridListSetItemText(GUIEditor.gridlist[1], 0, 1, "Almanya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 1, 1, "Amerika", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 2, 1, "Arjantin", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 3, 1, "Arnavutluk", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 4, 1, "Avusturalya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 5, 1, "Avusturya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 6, 1, "Belcika", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 7, 1, "Brezilya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 8, 1, "Bulgaristan", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 9, 1, "Danimarka", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 10, 1, "Fransa", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 11, 1, "Guney_Afrika", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 12, 1, "Guney_Kore", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 13, 1, "Hollanda", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 14, 1, "Jamaika", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 15, 1, "Japonya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 16, 1, "Kanada", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 17, 1, "Kolombiya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 18, 1, "Kuba", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 19, 1, "Litvanya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 20, 1, "Macaristan", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 21, 1, "Makedonya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 22, 1, "Meksika", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 23, 1, "Misir", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 24, 1, "Nijerya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 25, 1, "Norvec", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 26, 1, "Peru", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 27, 1, "Polonya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 28, 1, "Portekiz", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 29, 1, "Romanya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 30, 1, "Rusya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 31, 1, "Slovakya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 32, 1, "Sirbistan", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 33, 1, "Ukrayna", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 34, 1, "Vietnam", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 35, 1, "Yeni_Zellanda", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 36, 1, "Yunanistan", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 37, 1, "Cin", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 38, 1, "Ingiltere", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 39, 1, "Irlanda", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 40, 1, "Iskocya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 41, 1, "Ispanya", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 42, 1, "Israil", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 43, 1, "Isvec", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 44, 1, "Isvicre", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 45, 1, "Italya", false, false)  
				guiGridListSetItemText(GUIEditor.gridlist[1], 46, 1, "Panama", false, false)
				showCursor(true)  
        addEventHandler("onClientGUIClick",GUIEditor.button[1],bayrakEkle)
end
addEvent("ulkePaneliniAc",true)
addEventHandler("ulkePaneliniAc",getRootElement(),ulkePanel)

function bayrakEkle()
	local liste = GUIEditor.gridlist[1]

    local pencere = GUIEditor.window[1]

    if source == GUIEditor.button[1] then
		local myItemData = guiGridListGetItemText(liste,guiGridListGetSelectedItem(liste),1)
-------------------------------------------------------------------------------
				triggerServerEvent("yok",getLocalPlayer(),getLocalPlayer())
				showCursor(false)
				destroyElement(pencere)    
-------------------------------------------------------------------------------
				if source and myItemData then
						if myItemData == "Amerika" then
							triggerServerEvent("amerika",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Almanya" then
							triggerServerEvent("almanya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Rusya" then
							triggerServerEvent("rusya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Avusturalya" then
							triggerServerEvent("avusturalya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Arjantin" then
							triggerServerEvent("arjantin",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Belcika" then
							triggerServerEvent("belcika",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Bulgaristan" then
							triggerServerEvent("bulgaristan",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Cin" then
							triggerServerEvent("cin",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Fransa" then
							triggerServerEvent("fransa",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Brezilya" then
							triggerServerEvent("brezilya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Ingiltere" then
							triggerServerEvent("ingiltere",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Irlanda" then
							triggerServerEvent("irlanda",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Iskocya" then
							triggerServerEvent("iskocya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Israil" then
							triggerServerEvent("israil",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Isvec" then
							triggerServerEvent("isvec",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Isvicre" then
							triggerServerEvent("isvicre",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Italya" then
							triggerServerEvent("italya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Jamaika" then
							triggerServerEvent("jamaika",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Japonya" then
							triggerServerEvent("japonya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Kanada" then
							triggerServerEvent("kanada",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Kolombiya" then
							triggerServerEvent("kolombiya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Kuba" then
							triggerServerEvent("küba",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Litvanya" then
							triggerServerEvent("litvanya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Macaristan" then
							triggerServerEvent("macaristan",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Makedonya" then
							triggerServerEvent("makedonya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Meksika" then
							triggerServerEvent("meksika",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Nijerya" then
							triggerServerEvent("nijerya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Norvec" then
							triggerServerEvent("norvec",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Peru" then
							triggerServerEvent("peru",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Portekiz" then
							triggerServerEvent("portekiz",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Romanya" then
							triggerServerEvent("romanya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Sirbistan" then
							triggerServerEvent("sirbistan",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Slovakya" then
							triggerServerEvent("slovakya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Ukrayna" then
							triggerServerEvent("ukrayna",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Yunanistan" then
							triggerServerEvent("yunanistan",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Danimarka" then
							triggerServerEvent("danimarka",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Yeni_Zellanda" then
							triggerServerEvent("yeni_zellanda",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Polonya" then
							triggerServerEvent("polonya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Guney_Kore" then
							triggerServerEvent("guney_kore",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Hollanda" then
							triggerServerEvent("hollanda",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Arnavutluk" then
							triggerServerEvent("arnavutluk",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Ispanya" then
							triggerServerEvent("ispanya",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Vietnam" then
							triggerServerEvent("vietnam",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Misir" then
							triggerServerEvent("mısır",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Guney_Afrika" then
							triggerServerEvent("güney_afrika",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end

						if myItemData == "Panama" then
							triggerServerEvent("panama",getLocalPlayer(),getLocalPlayer())
							showCursor(false)
							destroyElement(pencere)
						end
				end
		end
end