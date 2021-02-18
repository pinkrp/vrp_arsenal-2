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



local basics = {
	{"taser",1500},
	{"cassetete",500},
	{"lanterna",500},
	{"colete",500},
	{"radio",500}
}

local semi = {
	{"atifx45",5000},
	{"glock",5000},
	{"spas12",5000}
}


local auto = {
	{"mp5",15000},
	{"g36c",25000},
	{"m4a1",25000},
	{"m4a4",25000},
}

local ammo = {
	{"m-atifx45",15},
	{"m-glock",15},
	{"m-spas12",20},
	{"m-mp5",20},
	{"m-g36c",35},
	{"m-m4a1",35},
	{"m-m4a4",35}
}

----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.autoList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		for k,v in pairs(auto) do
			table.insert(itemlist,{index = v, name = vRP.getNameIndex(v), desc = vRP.getDescIndex(v), img = v})
		end
		return itemlist
	end
end


function src.semiList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		for k,v in pairs(semi) do
			table.insert(itemlist,{index = v, name = vRP.getNameIndex(v), desc = vRP.getDescIndex(v), img = v})
		end
		return itemlist
	end
end


function src.ammoList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		for k,v in pairs(ammo) do
			table.insert(itemlist,{index = v, name = vRP.getNameIndex(v), desc = vRP.getDescIndex(v), img = v})
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
			if v[2] == item then
				return v[1]
			end
		end	
	end	
end

function vRP.getNameIndex(item)
	if item ~= nil then
		for k,v in pairs(itemlist) do
			if v[1] == item then
				return v[2]
			end
		end	
	end	
end

function vRP.getDescIndex(item)
	if item ~= nil then
		for k,v in pairs(itemlist) do
			if v[1] == item then
				return v[4]
			end
		end	
	end	
end

function vRP.getIndexBody(item)
	if item ~= nil then
		for k,v in pairs(itemlist) do
			if v[1] == item then
				return k
			end
		end	
	end	
end

function vRP.getNameBody(item)
	if item ~= nil then
		for k,v in pairs(itemlist) do
			if v[2] == item then
				return k
			end
		end	
	end	
end

]]