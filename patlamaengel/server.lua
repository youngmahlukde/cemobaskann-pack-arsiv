function arabapatlamaengel()
  local arabacan=getElementHealth(source)
  if arabacan<=260 then
    setElementHealth(source,250)
    setVehicleEngineState(source,false)
  end
end
function arababinme()
  local arabacan=getElementHealth(source)
  if arabacan<260 then
    setVehicleEngineState(source,false)
  end
end
addEventHandler("onVehicleEnter",root,arababinme)
addEventHandler("onVehicleDamage",root,arabapatlamaengel)