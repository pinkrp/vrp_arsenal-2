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


function src.takeGun(index,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("skD/returnGun",{weapon = index})
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			if rows[1] then
				if parseInt(rows[1].qtd) > 0 then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(vRP.getIndexBody(index)) <= vRP.getInventoryMaxWeight(user_id) then
						vRP.giveInventoryItem(user_id,vRP.getIndexBody(index),parseInt(amount))
						vRP.execute("skD/updateGun",{qtd = parseInt(rows[1].qtd-amount),weapon = index})
						TriggerClientEvent("Notify",source,"Você pegou "..amount.."x "..vRP.getNameIndex(index)..".","Concluído","Verde")
					else
						TriggerClientEvent("Notify",source,"Sem espaço no inventário.","Impossível","Vermelho")
					end
				else
					TriggerClientEvent("Notify",source,"Sem estoque.","Impossível","Vermelho")
				end
			else 
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(vRP.getIndexBody(index)) <= vRP.getInventoryMaxWeight(user_id) then
					vRP.giveInventoryItem(user_id,vRP.getIndexBody(index),parseInt(amount))
					TriggerClientEvent("Notify",source,"Você pegou "..amount.."x "..vRP.getNameIndex(index)..".","Concluído","Verde")
				else
					TriggerClientEvent("Notify",source,"Sem espaço no inventário.","Impossível","Vermelho")
				end	
			end	
		end
	end
end

function src.giveGun(index,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("skD/returnGun",{weapon = index})
	if user_id then
		if rows[1] then
			if vRP.hasPermission(user_id,"admin.permissao") then
				if vRP.tryGetInventoryItem(user_id,vRP.getIndexBody(index),amount) then
					vRP.execute("skD/updateGun",{qtd = parseInt(rows[1].qtd+amount),weapon = index})
					TriggerClientEvent("Notify",source,"Você devolveu "..amount.."x "..vRP.getNameIndex(index)..".","Concluído","Verde")
				end					
			end
		else 
			if vRP.tryGetInventoryItem(user_id,vRP.getIndexBody(index),amount) then
				TriggerClientEvent("Notify",source,"Você devolveu "..amount.."x "..vRP.getNameIndex(index)..".","Concluído","Verde")
			end					
		end	
	end
end



function src.buyGun(index,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("skD/returnGun",{weapon = index})
	if user_id and rows[1] then
		if vRP.hasPermission(user_id,"admin.permissao") then
			if vRP.tryGetInventoryItem(user_id,"dinheirosujo",parseInt(rows[1].price*amount)) then
				SetTimeout(15000,function()
					vRP.execute("skD/updateGun",{qtd = parseInt(rows[1].qtd+amount),weapon = index})
					TriggerClientEvent("Notify",source,"Sua encomenda de "..amount.."x "..vRP.getNameIndex(index).." chegou.","Concluído","Verde")
				end)
			elseif vRP.tryFullPayment(user_id,parseInt(rows[1].price*amount)) then
				SetTimeout(15000,function()
					vRP.execute("skD/updateGun",{qtd = parseInt(rows[1].qtd+amount),weapon = index})
					TriggerClientEvent("Notify",source,"Sua encomenda de "..amount.."x "..vRP.getNameIndex(index).." chegou.","Concluído","Verde")
				end)
			else
				TriggerClientEvent("Notify",source,"Você não possui dinheiro para encomendar.","Impossível","Vermelho")		
			end			
		end
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
            if v.nome == item then
                return v.index
            end
        end    
    end    
end
function vRP.getNameIndex(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v.index == item then
                return v.nome
            end
        end    
    end    
end
function vRP.getDescIndex(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v.index == item then
                return v.desc
            end
        end    
    end    
end
function vRP.getIndexBody(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v.index == item then
                return k
            end
        end    
    end    
end
function vRP.getNameBody(item)
    if item ~= nil then
        for k,v in pairs(itemlist) do
            if v.nome == item then
                return k
            end
        end    
    end    
end
]]
