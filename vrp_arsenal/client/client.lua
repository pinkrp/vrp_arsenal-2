-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_arsenal",src)
vSERVER = Tunnel.getInterface("vrp_arsenal")


local actived = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopClose",function(data)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	active = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("autoList",function(data,cb)
	local shopitens = vSERVER.autoList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)

RegisterNUICallback("semiList",function(data,cb)
	local shopitens = vSERVER.semiList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)

RegisterNUICallback("ammoList",function(data,cb)
	local shopitens = vSERVER.ammoList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)

RegisterNUICallback("equipList",function(data,cb)
	local shopitens = vSERVER.equipList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SHOPBUY
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("take",function(data)
 	if data.index ~= nil then
 		--vSERVER.takeGun(data.index,data.amount)
 	end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = GetDistanceBetweenCoords(x,y,z,484.47,-1001.79,25.74,true)
		if distance <= 1.0 and not active then
			DrawText3Ds(484.47,-1001.79,25.74,"~g~E ~w~ARSENAL")	
			if IsControlJustPressed(0,38) and vSERVER.checkPerm() then
				TransitionToBlurred(1000)
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				active = true
			end				
		end
	end	
end)






function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end