-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_arsenal",src)
vCLIENT = Tunnel.getInterface("vrp_arsenal")



vRP.prepare("skD/returnType", "SELECT * FROM skd_arsenal WHERE type=@type")
vRP.prepare("skD/returnGun", "SELECT * FROM skd_arsenal WHERE weapon=@weapon")
vRP.prepare("skD/updateGun", "UPDATE skd_arsenal SET qtd=@qtd WHERE weapon=@weapon")





local basics = {
	"taser",
	"cassetete",
	"lanterna",
	"colete",
	"radio"
}


----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.autoList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		local guns = vRP.query("skD/returnType",{type = "AUTO"})
		for k,v in pairs(guns) do
			table.insert(itemlist,{index = guns[k].weapon, name = vRP.getNameIndex(guns[k].weapon), desc = vRP.getDescIndex(guns[k].weapon), qtd = guns[k].qtd, img = guns[k].weapon})
		end
		return itemlist
	end
end


function src.semiList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		local guns = vRP.query("skD/returnType",{type = "SEMI"})
		for k,v in pairs(guns) do
			table.insert(itemlist,{index = guns[k].weapon, name = vRP.getNameIndex(guns[k].weapon), desc = vRP.getDescIndex(guns[k].weapon), qtd = guns[k].qtd, img = guns[k].weapon})
		end
		return itemlist
	end
end


function src.ammoList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		local guns = vRP.query("skD/returnType",{type = "AMMO"})
		for k,v in pairs(guns) do
			table.insert(itemlist,{index = guns[k].weapon, name = vRP.getNameIndex(guns[k].weapon), desc = vRP.getDescIndex(guns[k].weapon), qtd = guns[k].qtd, img = guns[k].weapon})
		end
		return itemlist
	end
end


function src.equipList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		for k,v in pairs(basics) do
			table.insert(itemlist,{index = v,name = vRP.getNameIndex(v), desc = vRP.getDescIndex(v), img = v})
		end
		return itemlist
	end
end








-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPerm()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.geral")
	end
end


--[[ COLOCAR ISSO NO SEU vrp/modules/inventory.lua

function vRP.getIndexName(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v[nome] == item then
                return v[index]
            end
        end    
    end    
end
function vRP.getNameIndex(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v[index] == item then
                return v[nome]
            end
        end    
    end    
end
function vRP.getDescIndex(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v[index] == item then
                return v[desc]
            end
        end    
    end    
end
function vRP.getIndexBody(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v[index] == item then
                return k
            end
        end    
    end    
end
function vRP.getNameBody(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v[nome] == item then
                return k
            end
        end    
    end    
end
]]
