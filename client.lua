--[[
─────────────────────────────────────────────────────────────────

	HealingPads (client.lua) - Created by Lama
	
	Support - Lama#9612 on Discord
	
	DO NOT EDIT BELOW IF YOU DON'T KNOW WHAT YOU ARE DOING	

─────────────────────────────────────────────────────────────────
]]--

Citizen.CreateThread(function()
    for _, item in pairs(Config.Blips) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipColour(item.blip, item.color)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, item in pairs(Config.Blips) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 20 then
                -- 23 is the marker type, refer to this if you want to change it https://docs.fivem.net/docs/game-references/markers/
                -- 248, 138, 138 are the RGB values that determines the color of the blip
                DrawMarker(23, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 248, 138, 138, 200)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 2 then
                    DisplayHelpText("Press ~INPUT_VEH_HORN~ to get treated by hospital staff", 0)
                    -- Default key is E (38). Refer to this if you want to change it https://docs.fivem.net/docs/game-references/controls/
                    if (IsControlJustPressed(1, 38)) then
                        if (GetEntityHealth(GetPlayerPed(-1)) < 200) then                          
                            SetEntityHealth(GetPlayerPed(-1), 200)
                            if Config.UseND == true then
                                price = math.random(Config.PriceMin, Config.PriceMax)
                                TriggerServerEvent('pay', price)
                                DisplayNotification("~g~You have been succesfully treated.~s~ Price: $" .. price)
                            else
                                DisplayNotification("~g~You have been succesfully treated.")
                            end
                        else
                            DisplayNotification("~r~You don't need treatment.")
                        end
                    end
                end
            end
        end
    end
end)

-- Functions
function DisplayNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DisplayHelpText(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end