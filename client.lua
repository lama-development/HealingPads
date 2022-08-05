--[[
─────────────────────────────────────────────────────────────────

	HealingPads (client.lua) - Created by Lama
	
	Support - Lama#9612 on Discord
	
	DO NOT EDIT BELOW IF YOU DON'T KNOW WHAT YOU ARE DOING	

─────────────────────────────────────────────────────────────────
]]--

local ped
local distance

-- Notification above map
function DisplayNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Help text top left of screen
function DisplayHelpText(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

-- Create hospital blips
CreateThread(function()
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

-- Get ped and distance from healing pad.
CreateThread(function()
    while true do
        Wait(200)
        ped = PlayerPedId()
        for _, item in pairs(Config.Blips) do
            distance = #(GetEntityCoords(ped) - vector3(item.x, item.y, item.z))
        end
    end
end)

-- See healing pads when near, and when inside a healing pad and E is pressed then heal and pay if using ND.
CreateThread(function()
    while true do
        Wait(0)
        for _, item in pairs(Config.Blips) do
            if distance <= 20.0 then
                -- 23 is the marker type, refer to this if you want to change it https://docs.fivem.net/docs/game-references/markers/
                -- 248, 138, 138 are the RGB values that determines the color of the blip
                DrawMarker(23, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 248, 138, 138, 200)
            end
            if distance <= 2.0 then
                DisplayHelpText("Press ~INPUT_VEH_HORN~ to get treated by hospital staff", 0)
                -- Default key is E (38). Refer to this if you want to change it https://docs.fivem.net/docs/game-references/controls/
                if IsControlJustPressed(1, 38) then
                    if GetEntityHealth(ped) < 200 then                          
                        SetEntityHealth(ped, 200)
                        if Config.UseND then
                            local price = math.random(Config.PriceMin, Config.PriceMax)
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
end)