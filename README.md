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
<p>Change prices in the following files:</p>
lsconfig.lua<br />
cfg / serverconfig.lua<br />
Both should have the same values.
