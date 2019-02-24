--[[
Los Santos Customs V1.1
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-- RESOURCE TUNNEL/PROXY
vRPLSs = {}
Tunnel.bindInterface("vrp_lscustom",vRPLSs)
Proxy.addInterface("vrp_lscustom",vRPLSs)
ADVclient = Tunnel.getInterface("vrp_adv_garages")
LSClient = Tunnel.getInterface("vrp_lscustom")


local cfg = module("vrp_lscustom", "cfg/serverconfig")

local tbl = {
	[1] = {locked = false, player = nil},
	[2] = {locked = false, player = nil},
	[3] = {locked = false, player = nil},
	[4] = {locked = false, player = nil},
	[5] = {locked = false, player = nil},
	[6] = {locked = false, player = nil},
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

function checkModsPrice(button)
	if button.modtype ~=nil and button.mod ~= nil then
		local modtype = button.modtype
		local modindex = button.mod
		local wtype = button.wtype
		--print("button: "..vRP.dump(button))
		--print(modtype .. "/////" .. modindex)

		if modtype == 22 or modtype == 18 or modtype == 16 or modtype == 15 or modtype == 14 or modtype == 13 or modtype == 12 or modtype == 11 then
			for c,v in ipairs(cfg.mods[modtype]) do
				if v.mod == modindex then
					value = v.price
				end
			end
		elseif modtype == 24 and wtype then
			if wtype == 6 then
				for w,t in pairs(cfg.backwheel) do
					if t.mod == modindex then
						value = t.price
					end
				end
			end
		elseif modtype == 23 and wtype then
			if wtype == 0 then
				for w,t in pairs(cfg.sportwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 1 then
				for w,t in ipairs(cfg.musclewheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 2 then
				for w,t in ipairs(cfg.lowriderwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 3 then
				for w,t in ipairs(cfg.suvwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 4 then
				for w,t in ipairs(cfg.offroadwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 5 then
				for w,t in ipairs(cfg.tunerwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 6 then
				for w,t in ipairs(cfg.frontwheel) do
					if t.mod == modindex then
						value = t.price
					end
				end
			elseif wtype == 7 then
				for w,t in ipairs(cfg.highendwheels) do
					if t.mod == modindex then
						value = t.price
					end
				end
			end
		else
			--print("CAIU AQUI SAPORRA?")
			if modindex == -1 then
				value = 0
			else
				value = cfg.mods[modtype].startprice
			end
		end
	else
		value = 0
	end
	return value
end

function toogleTrue(value)
	if value == 1 then
		value = true
	end
	return value
end

function vRPLSs.saveCustomsVeh(veh)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		local model = veh.model --Display name from vehicle model(comet2, entityxf)
		local vehid = veh.vehicle -- get id vehicle
		local plate = veh.plate
		local mods = veh.mods

		local vtype, vehname = ADVclient.isOwnedVehicleOutID(player, vehid)

		if vtype and vehname then
			local custom = {}

			custom.plate = {}
			custom.plate.text = plate -- Licence ID
			custom.plate.index = veh.plateindex

			custom.colour = {}
			custom.colour.primary = veh.color[1] -- 1rst colour
			custom.colour.secondary = veh.color[2] -- 2nd colour
			custom.colour.pearlescent = veh.extracolor[1] -- colour type
			custom.colour.wheel = veh.extracolor[2] -- wheel colour
			-- colors[1] = custom.colour.primary
			-- colors[2] = custom.colour.secondary
			-- colors[3] = custom.colour.pearlescent
			-- colors[4] = custom.colour.wheel
			custom.neon = {}
			custom.neon.left = veh.neon.left
			custom.neon.right = veh.neon.right
			custom.neon.front = veh.neon.front
			custom.neon.back = veh.neon.back

			custom.colour.neon = veh.neoncolor
			custom.colour.smoke = veh.smokecolor
			--
			-- custom.colour.custom = {}
			-- custom.colour.custom.primary = table.pack(GetVehicleCustomPrimaryColour(veh))
			-- custom.colour.custom.secondary = table.pack(GetVehicleCustomSecondaryColour(veh))
			--
			custom.mods = {}
			for i=0,48 do
				custom.mods[i] = tonumber(mods[i].mod)
			end

			-- custom.mods[18] = IsToggleModOn(veh,18)
			-- custom.mods[20] = IsToggleModOn(veh,20)
			-- custom.mods[22] = IsToggleModOn(veh,22)
			--
			-- mods = custom.mods
			--
			-- custom.mods[18] = mods[18].mod -- bool
			-- custom.mods[20] = mods[20].mod -- bool
			-- custom.mods[22] = mods[22].mod -- bool
			custom.mods[46] = veh.windowtint -- Tinted Windows
			--
			-- custom.neon = {}
			-- custom.neon.left = IsVehicleNeonLightEnabled(veh,0)
			-- custom.neon.right = IsVehicleNeonLightEnabled(veh,1)
			-- custom.neon.front = IsVehicleNeonLightEnabled(veh,2)
			-- custom.neon.back = IsVehicleNeonLightEnabled(veh,3)
			--
			-- custom.bulletproof = GetVehicleTyresCanBurst(veh)
			custom.variation = mods[23].mod
			custom.wheel = veh.wheeltype -- Wheel Type
			-- wheel = custom.wheel

			--print("veh: ".. json.encode(custom))

			vRPclient._notify(player, "Customizações foram Salvos")
			vRP.setSData("custom:u"..user_id.."veh_"..vehname, json.encode(custom))
		end

		--[[
		mods[0].mod - spoiler
		mods[1].mod - front bumper
		mods[2].mod - rearbumper
		mods[3].mod - skirts
		mods[4].mod - exhaust
		mods[5].mod - roll cage
		mods[6].mod - grille
		mods[7].mod - hood
		mods[8].mod - fenders
		mods[10].mod - roof
		mods[11].mod - engine
		mods[12].mod - brakes
		mods[13].mod - transmission
		mods[14].mod - horn
		mods[15].mod - suspension
		mods[16].mod - armor
		mods[23].mod - tires
		mods[23].variation - custom tires
		mods[24].mod - tires(Just for bikes, 23:front wheel 24:back wheel)
		mods[24].variation - custom tires(Just for bikes, 23:front wheel 24:back wheel)
		mods[25].mod - plate holder
		mods[26].mod - vanity plates
		mods[27].mod - trim design
		mods[28].mod - ornaments
		mods[29].mod - dashboard
		mods[30].mod - dial design
		mods[31].mod - doors
		mods[32].mod - seats
		mods[33].mod - steering wheels
		mods[34].mod - shift leavers
		mods[35].mod - plaques
		mods[36].mod - speakers
		mods[37].mod - trunk
		mods[38].mod - hydraulics
		mods[39].mod - engine block
		mods[40].mod - cam cover
		mods[41].mod - strut brace
		mods[42].mod - arch cover
		mods[43].mod - aerials
		mods[44].mod - roof scoops
		mods[45].mod - tank
		mods[46].mod - doors
		mods[48].mod - liveries

		--Toggle mods
		mods[20].mod - tyre smoke
		mods[22].mod - headlights
		mods[18].mod - turbo

		--]]
		-- local color = veh.color
		-- local extracolor = veh.extracolor
		-- local neoncolor = veh.neoncolor
		-- local smokecolor = veh.smokecolor
		-- local plateindex = veh.plateindex
		-- local windowtint = veh.windowtint
		-- local wheeltype = veh.wheeltype
		-- local bulletProofTyres = veh.bulletProofTyres
		--Do w/e u need with all this stuff when vehicle drives out of lsc
	end
end

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)

	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	--print(player)
	if user_id ~= nil then
		local model = veh.model --Display name from vehicle model(comet2, entityxf)
		local vehid = veh.vehicle -- get id vehicle
		local plate = veh.plate
		local mods = veh.mods

		local vtype, vehname = ADVclient.isOwnedVehicleOutID(player, vehid)

		if vtype and vehname then
			vRPLSs.saveCustomsVeh(veh)
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, veh)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local model = veh.model or false
	local vehid = veh.vehicle
	local price = button.price
	local mod = button.mod
	if user_id ~= nil then
		if price ~= nil and model then
			local priceserv = checkModsPrice(button)
			if (price >= priceserv and mod) or (not mod) then -- check if button have price
				local vtype, vehname = ADVclient.isOwnedVehicleOutID(player, vehid)
				if vtype and vehname then
					if vRP.tryFullPayment(user_id,price) then
						TriggerClientEvent("LSC:buttonSelected", player,name, button, true)
						local myveh = LSClient.getAllMods(player)
						vRPLSs.saveCustomsVeh(myveh)
					else
						TriggerClientEvent("LSC:buttonSelected", player,name, button, false)
					end
				else
					TriggerClientEvent("LSC:buttonSelected", player,name, button, false)
					vRPclient._notify(player, "Este veículo não é seu, não é possivel customizar!")
				end
			end
		end
	end
end)
