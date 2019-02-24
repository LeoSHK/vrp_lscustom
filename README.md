# vrp_lscustom
Los Santos Custom for VRPex
Original: https://forum.fivem.net/t/los-santos-customs-bennys-motorworks-v1-2/52044

<h1>Requirements</h1>
<p><strong>vRP framework</strong> (vRPex Version: https://github.com/ImagicTheCat/vRP)</p>
<p><strong>vrp_adv_garages</strong> (https://github.com/Sighmir/FiveM-Scripts/tree/master/vrpex/vrp_adv_garages)</p>

<h1>How to configure</h1>

Open client.lua vrp_adv_garages and add this function to the nearest line 567
```
function vRPg.isOwnedVehicleOutID(veh)
  for vtype,vehicle in pairs(vehicles) do
    if vehicle[3] == veh then
      return vtype, vehicle[2]
    end
  end
  return false, false
end
```

Replace this function in vrp_adv_garages / client.lua if you do not load customizations on the vehicles.
```
function vRPg.setVehicleMods(custom)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsUsing(ped)
  if custom and veh then
    SetVehicleModKit(veh,0)
    if custom.colour then
      SetVehicleColours(veh, tonumber(custom.colour.primary), tonumber(custom.colour.secondary))
      SetVehicleExtraColours(veh, tonumber(custom.colour.pearlescent), tonumber(custom.colour.wheel))
      if custom.colour.neon then
        --print(dump(custom.colour.neon))
        SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
      end
      if custom.colour.smoke then
        --print(custom.colour.smoke[1])
        SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
      end
      if custom.colour.custom then
        if custom.colour.custom.primary then
          SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
        end
        if custom.colour.custom.secondary then
          SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
        end
      end
    end

    if custom.plate then
      SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
    end

    SetVehicleWindowTint(veh,tonumber(custom.mods['46'])) -- int

    if tonumber(custom.bulletproof) == 1 then
      SetVehicleTyresCanBurst(veh, true) -- bool
    end

    SetVehicleWheelType(veh, tonumber(custom.wheel)) -- int

    if tonumber(custom.mods['18']) == 1 then
      ToggleVehicleMod(veh, 18, true) -- bool
    end
    if tonumber(custom.mods['20']) == 1 then
      ToggleVehicleMod(veh, 20, true) -- bool
    end
    if tonumber(custom.mods['22']) == 1 then
      ToggleVehicleMod(veh, 22, true) -- bool
    end

    --ToggleVehicleMod(veh, 20, tonumber(custom.mods[20])) -- bool
    --ToggleVehicleMod(veh, 22, tonumber(custom.mods[22])) -- bool

    if custom.neon then
      if tonumber(custom.neon.left) == 1 then
        SetVehicleNeonLightEnabled(veh,0, true) -- bool
      end
      if tonumber(custom.neon.right) == 1 then
        SetVehicleNeonLightEnabled(veh,1, true) -- bool
      end
      if tonumber(custom.neon.front) == 1 then
        SetVehicleNeonLightEnabled(veh,2, true) -- bool
      end
      if tonumber(custom.neon.back) == 1 then
        SetVehicleNeonLightEnabled(veh,3, true) -- bool
      end

      -- SetVehicleNeonLightEnabled(veh,0, custom.neon.left) -- bool
      -- SetVehicleNeonLightEnabled(veh,1, custom.neon.right) -- bool
      -- SetVehicleNeonLightEnabled(veh,2, custom.neon.front) -- bool
      -- SetVehicleNeonLightEnabled(veh,3, custom.neon.back) -- bool
    end

    for i,mod in pairs(custom.mods) do
      if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
        SetVehicleMod(veh, tonumber(i), tonumber(mod))
      end
    end

  end
end
```

<p>Change prices in the following files:</p>
lsconfig.lua<br />
cfg / serverconfig.lua<br />
Both should have the same values.
