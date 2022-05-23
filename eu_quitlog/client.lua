

        local screenW, screenH = guiGetScreenSize()
        window = guiCreateWindow((screenW - 730) / 2, (screenH - 406) / 2, 730, 406, "Yakın Çevrede Çıkan Oyuncular Crown:Creation", false)
        guiWindowSetSizable(window, false)
       guiSetVisible(window,false)
        gridlist = guiCreateGridList(9, 25, 711, 315, false, window)
        guiGridListAddColumn(gridlist, "Karakter Adı", 0.2)
        guiGridListAddColumn(gridlist, "Kullanıcı Adı", 0.2)
        guiGridListAddColumn(gridlist, "Çıkış Sebebi", 0.2)
        guiGridListAddColumn(gridlist, "Uzaklık(mt)", 0.2)
        guiGridListAddColumn(gridlist, "Konum", 0.2)
        guiGridListAddColumn(gridlist, "Tarih", 0.2)
        closeButton = guiCreateButton(9, 356, 712, 34, "Arayüzü Kapat", false, window)    


function closeWindow()
    if source == closeButton then
        guiSetVisible(window,false)
        showCursor(false)
    end
end
addEventHandler('onClientGUIClick',resourceRoot,closeWindow)

function openWindow()
    guiSetVisible(window,not guiGetVisible(window))
    showCursor(not isCursorShowing())
end
addCommandHandler('quitlog',openWindow)
addCommandHandler('yakındacıkanlar',openWindow)

function addPlayer(name,username,reason,mt,location,history)
    local row = guiGridListAddRow ( gridlist )
    guiGridListSetItemText(gridlist,row,1,name,false,true)
    guiGridListSetItemText(gridlist,row,2,username,false,true)
    guiGridListSetItemText(gridlist,row,3,reason,false,true)
    guiGridListSetItemText(gridlist,row,4,mt,false,true)
    guiGridListSetItemText(gridlist,row,5,location,false,true)
    guiGridListSetItemText(gridlist,row,6,history,false,true)
end
addEvent('quitlog:addPlayer',true)
addEventHandler('quitlog:addPlayer',root,addPlayer)
